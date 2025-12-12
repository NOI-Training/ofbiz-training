<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password | Apache OFBiz</title>
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

        .forgot-container {
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

        h2 {
            text-align: center;
            color: #fff;
            margin-bottom: 15px;
            font-size: 26px;
            font-weight: 600;
        }

        p {
            text-align: center;
            color: #cde3ff;
            font-size: 14px;
            margin-bottom: 25px;
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

        .btn-submit {
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
            color: #fff;
        }

        .btn-submit:hover {
            background: #0072ff;
        }

        .error-message {
            background: rgba(255,0,0,0.3);
            padding: 10px;
            border-radius: 8px;
            text-align: center;
            color: #fff;
            margin-bottom: 15px;
        }

        .back-link {
            text-align: center;
            margin-top: 15px;
        }

        .back-link a {
            color: #cde3ff;
            font-size: 14px;
            text-decoration: none;
            transition: 0.3s;
        }

        .back-link a:hover { color: #fff; }

        @media(max-width: 480px) {
            .forgot-container { width: 90%; padding: 30px; }
        }
    </style>

</head>
<body>

<div class="forgot-container">

    <h2>Forgot Password</h2>
    <p>Enter your email or username to reset your password.</p>

    <#-- Display OFBiz error message -->
    <#if _ERROR_MESSAGE_?has_content>
        <div class="error-message">${_ERROR_MESSAGE_}</div>
    </#if>

    <form method="post" action="<@ofbizUrl>forgotPasswordReset</@ofbizUrl>">

        <div class="input-group">
            <label>Email / Username</label>
            <input type="text" name="USERNAME" placeholder="Enter your email or username" required />
        </div>

        <button type="submit" class="btn-submit">Send Reset Link</button>

    </form>

    <div class="back-link">
        <a href="<@ofbizUrl>login</@ofbizUrl>">Back to Login</a>
    </div>

</div>

</body>
</html>
