// Get the elements
const loginForm = document.getElementById('login-form');
const registerForm = document.getElementById('register-form');
const showRegisterButton = document.getElementById('show-register');
const showLoginButton = document.getElementById('show-login');

// Add event listeners
showRegisterButton.addEventListener('click', showRegisterForm);
showLoginButton.addEventListener('click', showLoginForm);

// Functions to toggle forms
function showRegisterForm() {
  loginForm.classList.add('hidden');
  registerForm.classList.remove('hidden');
}

function showLoginForm() {
  registerForm.classList.add('hidden');
  loginForm.classList.remove('hidden');
}