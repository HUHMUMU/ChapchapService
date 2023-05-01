

const confirmBtn = document.getElementById('confirmBtn');
confirmBtn.addEventListener('click', function() {
    const warningMsg = document.querySelector('.alert-warning');
    warningMsg.style.display = 'none';
});

const minusBtn = document.getElementById('minusBtn');
const plusBtn = document.getElementById('plusBtn');
const peopleInput = document.getElementById('people-input');

minusBtn.addEventListener('click', function() {
    const value = parseInt(peopleInput.value);
    if (value > 1) {
        peopleInput.value = value - 2;
    }
});

plusBtn.addEventListener('click', function() {
    const max = parseInt(peopleInput.getAttribute('max'));
    const value = parseInt(peopleInput.value);
    if (value < max) {
        peopleInput.value = value + 2;
    }
});