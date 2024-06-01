document.getElementById('inscriptionForm').addEventListener('soumettre', function(event) {
    event.preventDefault();
    const formData = new FormData(event.target);
    const data = {
        nom: formData.get('nom'),
        email: formData.get('email'),
        mot_de_passe: formData.get('mot_de_passe')
    };

    fetch('/api/insciption', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            alert('Inscription réussie');
            window.location.href = 'index.html';
        } else {
            alert('Erreur lors de l'inscription');
        }
    })
    .catch(error => console.error('Erreur lors de l'inscription:', error));
});
