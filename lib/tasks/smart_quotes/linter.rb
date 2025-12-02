module SmartQuotes
  class Linter
    include ActionView::Helpers::TextHelper
    SMART_QUOTES = {
      "\u2018" => { replace_with: "'", name: "left single quote" },    # ‘
      "\u2019" => { replace_with: "'", name: "right single quote" },   # ’
      "\u201C" => { replace_with: '"', name: "left double quote" },    # “
      "\u201D" => { replace_with: '"', name: "right double quote" },   # ”
      "\u2032" => { replace_with: "'", name: "prime" },                # ′
      "\u2033" => { replace_with: '"', name: "double prime" }          # ″
    }.freeze

    EXTENSIONS = %w[.css .erb .html .js .md .rb .scss .slim .yml].freeze
    EXCLUDED_PATTERNS = [
      "log/**/*",
      "storage/**/*",
      "tmp/**/*",
      "vendor/**/*",
      "lib/tasks/smart_quotes/**/*"
    ].freeze

    PROGRESS_BATCH_SIZE = 10

    COLORS = {
      red: "\e[31m",
      green: "\e[32m",
      cyan: "\e[36m",
      reset: "\e[0m"
    }.freeze

    def initialize(root_dir: ".")
      @root_dir = root_dir
    end

    def find
      files = file_list
      files_with_offenses = scan_files(files, show_progress: true)

      if files_with_offenses.any?
        print_offenses(files, files_with_offenses)
        1
      else
        print_success(files)
        0
      end
    end

    def replace
      files = file_list
      files_with_offenses = scan_files(files, show_progress: false)

      if files_with_offenses.empty?
        puts "No smart quotes found"
        return
      end

      result = replace_in_files(files_with_offenses) do |file_path, count|
        puts "✓ Fixed #{pluralize(count, 'smart quote')} in #{file_path}"
      end

      print_replacement_summary(result)
    end

    private

    def file_list
      Dir.glob(File.join(@root_dir, "**/*"))
        .select { |f| File.file?(f) && EXTENSIONS.include?(File.extname(f)) }
        .map { |f| f.delete_prefix("./") }
        .reject { |f|
          EXCLUDED_PATTERNS.any? { |pattern|
            File.fnmatch?(pattern, f, File::FNM_PATHNAME | File::FNM_EXTGLOB)
          }
        }
    end

    def absolute_path_for(file_path)
      File.join(@root_dir, file_path)
    end

    def scan_files(files, show_progress: false)
      puts "Inspecting #{pluralize(files.size, 'file')}" if show_progress

      files_with_offenses = []
      batch_offenses = []

      files.each_with_index do |file_path, index|
        offenses = scan_file(file_path)

        if offenses.any?
          files_with_offenses << { path: file_path, offenses: offenses }
          batch_offenses << true
        else
          batch_offenses << false
        end

        if show_progress && (index + 1) % PROGRESS_BATCH_SIZE == 0
          print_progress_indicator(batch_offenses)
          batch_offenses = []
        end
      end

      print_progress_indicator(batch_offenses) if show_progress && batch_offenses.any?
      puts if show_progress

      files_with_offenses
    end

    def scan_file(file_path)
      content = File.read(absolute_path_for(file_path), encoding: "UTF-8")
      return [] unless SMART_QUOTES.keys.any? { |q| content.include?(q) }

      offenses = []

      content.each_line.with_index(1) do |line, line_number|
        SMART_QUOTES.keys.each do |quote|
          column = 0
          while (pos = line.index(quote, column))
            offenses << {
              line: line_number,
              column: pos + 1,
              quote: quote
            }
            column = pos + 1
          end
        end
      end

      offenses
    end

    def replace_in_files(files_with_offenses)
      files_modified = 0
      total_replacements = 0

      files_with_offenses.each do |file_info|
        file_path = file_info[:path]
        original_content = File.read(file_path, encoding: "UTF-8")
        modified_content = original_content.dup
        file_replacements = 0

        SMART_QUOTES.each do |smart, info|
          count = 0
          modified_content.gsub!(smart) do
            count += 1
            info[:replace_with]
          end
          file_replacements += count
        end

        if modified_content != original_content
          File.write(file_path, modified_content, encoding: "UTF-8")
          files_modified += 1
          total_replacements += file_replacements
          yield(file_path, file_replacements) if block_given?
        end
      end

      { files_modified: files_modified, total_replacements: total_replacements }
    end

    def quote_name(quote)
      SMART_QUOTES[quote][:name]
    end

    def print_offenses(files, files_with_offenses)
      offense_count = files_with_offenses.sum { |f| f[:offenses].size }
      puts ""
      puts "Offenses:"
      puts ""

      files_with_offenses.each do |file_info|
        file_info[:offenses].each do |offense|
          puts "#{COLORS[:cyan]}#{file_info[:path]}#{COLORS[:reset]}:#{offense[:line]}:#{offense[:column]}: #{COLORS[:red]}F#{COLORS[:reset]}: contains #{quote_name(offense[:quote])} #{offense[:quote]}"
        end
        puts ""
      end

      puts "#{pluralize(files.size, 'file')} inspected, #{COLORS[:red]}#{pluralize(offense_count, 'offense')}#{COLORS[:reset]} detected"
      puts "\nTo fix these offenses, run:\n\n  bin/rails smart_quotes:replace\n\n"
    end

    def print_success(files)
      puts ""
      puts "#{pluralize(files.size, 'file')} inspected, #{COLORS[:green]}no offenses#{COLORS[:reset]} detected"
    end

    def print_replacement_summary(result)
      puts "\nReplaced #{pluralize(result[:total_replacements], 'smart quote')} in #{pluralize(result[:files_modified], 'file')}"
    end

    def print_progress_indicator(batch_offenses)
      color = batch_offenses.any? ? COLORS[:red] : COLORS[:green]
      char = batch_offenses.any? ? "F" : "."
      print "#{color}#{char}#{COLORS[:reset]}"
    end
  end
end
