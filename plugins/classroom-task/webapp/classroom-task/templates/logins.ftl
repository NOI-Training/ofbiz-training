<!DOCTYPE html>
<html>
<head>
    <title>Login | Apache OFBiz</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }

        body {
            background: linear-gradient(135deg, #4b6cb7, #182848);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-container {
            background: rgba(255,255,255,0.12);
            padding: 40px;
            width: 380px;
            border-radius: 18px;
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255,255,255,0.2);
            box-shadow: 0 5px 25px rgba(0,0,0,0.3);
            animation: fadeIn 0.8s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-container h2 {
            text-align: center;
            color: #fff;
            margin-bottom: 25px;
            font-size: 28px;
            font-weight: 600;
        }

        .input-group { margin-bottom: 18px; }
        .input-group label { color: #eee; font-size: 14px; }
        .input-group input {
            width: 100%;
            padding: 12px;
            margin-top: 6px;
            border-radius: 10px;
            border: none;
            outline: none;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: #00c6ff;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
            transition: 0.3s;
        }
        .btn-login:hover { background: #0072ff; }

        .error-message {
            background: rgba(255,0,0,0.3);
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            color: #fff;
            margin-bottom: 15px;
        }

        .extra-links {
            margin-top: 15px;
            text-align: center;
        }
        .extra-links a {
            color: #cde3ff;
            font-size: 14px;
            text-decoration: none;
            display: block;
            margin-top: 8px;
            transition: 0.3s;
        }
        .extra-links a:hover { color: #fff; }

        @media(max-width: 480px) {
            .login-container { width: 90%; padding: 30px; }
        }
    </style>

    <script>
        function validateForm() {
            let username = document.getElementById("USERNAME").value.trim();
            let password = document.getElementById("PASSWORD").value.trim();

            if (username === "" || password === "") {
                alert("Please fill all fields!");
                return false;
            }
            return true;
        }
    </script>
</head>

<body>

<div class="login-container">

    <h2>Welcome Back</h2>

    <#if _ERROR_MESSAGE_?has_content>
        <div class="error-message">${_ERROR_MESSAGE_}</div>
    </#if>

    <form method="post" action="<@ofbizUrl>login</@ofbizUrl>" onsubmit="return validateForm();">

        <div class="input-group">
            <label>Username / Email</label>
            <input type="text" id="USERNAME" name="USERNAME" placeholder="Enter Username">
        </div>

        <div class="input-group">
            <label>Password</label>
            <input type="password" id="PASSWORD" name="PASSWORD" placeholder="Enter Password">
        </div>

        <input type="hidden" name="JavaScriptEnabled" value="Y" />

        <button type="submit" class="btn-login">Login</button>
    </form>

    <div class="extra-links">
        <a href="<@ofbizUrl>forgotPassword</@ofbizUrl>">Forgot Password?</a>
    </div>

</div>

</body>
</html>
