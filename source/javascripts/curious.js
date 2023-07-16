const subscriptionSuccessAlert = document.getElementById('subscriptionSuccessAlert')

subscriptionSuccessAlert.addEventListener('close.bs.alert', (event) => {
  event.preventDefault()
  // event.stopPropagation()
  subscriptionSuccessAlert.classList.add('d-none')
})

const form = document.getElementById('newsletterSubscriptionForm')

form.addEventListener(
  'submit',
  (event) => {
    event.preventDefault()
    // event.stopPropagation()

    if (form.checkValidity()) {
      const formData = new FormData(form)

      fetch(form.action, { method: form.method, body: formData }).then((response) => {
        if (response.status == 201) {
          subscriptionSuccessAlert.classList.remove('d-none')

          form.reset()
          form.classList.remove('was-validated')
        } else {
        }
      })
    } else {
      form.classList.add('was-validated')
    }
  },
  false
)
