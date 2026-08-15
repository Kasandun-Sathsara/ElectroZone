async function sendOtp() {
    const email = document.getElementById('email').value;
    
    if (!email) {
        Notiflix.Notify.failure('Please enter your email address');
        return;
    }

    Notiflix.Loading.pulse('Sending OTP...');

    try {
        const response = await fetch('api/users/forgot-password/send-otp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email: email })
        });

        const data = await response.json();
        Notiflix.Loading.remove();

        if (data.status) {
            Notiflix.Notify.success(data.message);

            document.getElementById('step-1').classList.add('d-none');
            document.getElementById('step-2').classList.remove('d-none');
            document.getElementById('otp').focus();
        } else {
            Notiflix.Notify.failure(data.message);
        }
    } catch (error) {
        Notiflix.Loading.remove();
        Notiflix.Notify.failure('Failed to send OTP. Please try again.');
        console.error('Error:', error);
    }
}

async function verifyOtp() {
    const otp = document.getElementById('otp').value;
    
    if (!otp) {
        Notiflix.Notify.failure('Please enter the OTP');
        return;
    }

    Notiflix.Loading.pulse('Verifying OTP...');

    try {
        const response = await fetch('api/users/forgot-password/verify-otp', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ verificationCode: otp })
        });

        const data = await response.json();
        Notiflix.Loading.remove();

        if (data.status) {
            Notiflix.Notify.success(data.message);

            document.getElementById('step-2').classList.add('d-none');
            document.getElementById('step-3').classList.remove('d-none');
            document.getElementById('new-password').focus();
        } else {
            Notiflix.Notify.failure(data.message);
        }
    } catch (error) {
        Notiflix.Loading.remove();
        Notiflix.Notify.failure('Failed to verify OTP. Please try again.');
        console.error('Error:', error);
    }
}

async function resetPassword() {
    const newPassword = document.getElementById('new-password').value;
    const confirmPassword = document.getElementById('confirm-password').value;
    
    if (!newPassword || !confirmPassword) {
        Notiflix.Notify.failure('Please fill in both password fields');
        return;
    }

    if (newPassword !== confirmPassword) {
        Notiflix.Notify.failure('Passwords do not match!');
        return;
    }

    Notiflix.Loading.pulse('Updating password...');

    try {
        const response = await fetch('api/users/forgot-password/reset', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ password: newPassword })
        });

        const data = await response.json();
        Notiflix.Loading.remove();

        if (data.status) {
            Notiflix.Notify.success(data.message);

            setTimeout(() => {
                window.location.href = 'login.jsp';
            }, 2000);
        } else {
            Notiflix.Notify.failure(data.message);
        }
    } catch (error) {
        Notiflix.Loading.remove();
        Notiflix.Notify.failure('Failed to update password. Please try again.');
        console.error('Error:', error);
    }
}
