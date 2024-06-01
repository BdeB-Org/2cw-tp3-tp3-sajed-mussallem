document.addEventListener('DOMContentLoaded', () => {
    fetchPanier();
});

function fetchPanier() {
    fetch('/api/panier')
        .then(response => response.json())
        .then(data => populatePanierTable(data))
        .catch(error => console.error('Erreur lors de la récupération du panier:', error));
}

function populatePanierTable(panier) {
    const tableBody = document.getElementById('panierTable').getElementsByTagName('tbody')[0];
    panier.forEach(item => {
        const row = tableBody.insertRow();
        row.insertCell(0).textContent = item.titre;
        row.insertCell(1).textContent = item.auteur;
        row.insertCell(2).textContent = item.genre;
        row.insertCell(3).textContent = item.date_publication;
        row.insertCell(4).textContent = item.date_emprunt;
        row.insertCell(5).textContent = item.date_retour;
    });
}
