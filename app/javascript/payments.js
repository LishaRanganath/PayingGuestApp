document.addEventListener('DOMContentLoaded', function() {
    const paymentForm = document.getElementById('payments-form');
    paymentForm.addEventListener('submit', function(event) {
      event.preventDefault();
      const formData = new FormData(paymentForm);
      
      fetch(paymentForm.action, {
        method: paymentForm.method,
        body: formData
      })
      .then(response => response.json())
      .then(data => {
        if (data.success) {
          const downloadLink = document.createElement('a');
          downloadLink.href = data.download_url;
          downloadLink.textContent = 'Download Invoice';
          paymentForm.appendChild(downloadLink);
        }
      })
      .catch(error => console.error('Error:', error));
    });
  });