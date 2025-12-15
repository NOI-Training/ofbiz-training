<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.


<#if requestAttributes.uiLabelMap??><#assign uiLabelMap = requestAttributes.uiLabelMap></#if>
<#assign useMultitenant = Static["org.apache.ofbiz.base.util.UtilProperties"].getPropertyValue("general.properties", "multitenant")>

<#assign username = requestParameters.USERNAME?default((sessionAttributes.autoUserLogin.userLoginId)?default(""))>
<#if username != "">
  <#assign focusName = false>
<#else>
  <#assign focusName = true>
</#if>
  <div id="loginBar">
    <div id="company-logo"></div>
  </div>

  <div class="screenlet login-screenlet">
    <h3>${uiLabelMap.CommonBeLogged}</h3>
    <div class="screenlet-body">
      <form method="post" action="<@ofbizUrl>login</@ofbizUrl>" name="loginform">
        <label>
          ${uiLabelMap.CommonUsername}
          <input type="text" name="USERNAME" value="${username}" tabindex="0" required/>
        </label>
        
        <label>
          <span>
            ${uiLabelMap.CommonPassword}
          </span>
          <input type="password" name="PASSWORD" autocomplete="off" value="" tabindex="0" required/>
            <a href="<@ofbizUrl>forgotPassword</@ofbizUrl>">${uiLabelMap.CommonForgotYourPassword}</a>
        </label>

        <#if ("Y" == useMultitenant) >
          <#if !requestAttributes.userTenantId??>
          <label>
            ${uiLabelMap.CommonTenantId}
            <input type="text" name="userTenantId" value="${parameters.userTenantId!}"/>
          </label>
          <#else>
          <input type="hidden" name="userTenantId" value="${requestAttributes.userTenantId!}"/>
          </#if>
        </#if>

        <input type="submit" value="${uiLabelMap.CommonLogin}"  tabindex="0"/>
        <input type="hidden" name="JavaScriptEnabled" value="N"/>
        
      </form>
    </div>
  </div>

<script type="text/javascript">
  document.loginform.JavaScriptEnabled.value = "Y";
  <#if focusName>
    document.loginform.USERNAME.focus();
  <#else>
    document.loginform.PASSWORD.focus();
  </#if>
</script>
-->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>Animated Login</title>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>

  <style>
    :root {
      --bg: #f7f8fb;
      --card: #ffffff;
      --muted: #6b7280;
      --accent: #3b82f6;
    }

    html, body {
      height:100%; margin:0; font-family: Arial, sans-serif;
      background:var(--bg); color:#111827;
      overflow: hidden;
    }

    .login-wrapper {
      margin-top : 15vh;
      min-height:100%;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:24px;
    }

    .card {
      background:var(--card);
      border-radius:16px;
      box-shadow:0 10px 30px rgba(15,23,42,0.08);
      padding:32px;
      max-width:900px;
      width:100%;
      display:grid;
      grid-template-columns: 360px 1fr;
      gap:22px;
      align-items:center;
      animation: fadeIn 1s ease;
    }
    .password-wrapper {
          position: relative;
    }

    .password-wrapper input {
          width: 100%;
    }

   .visibility-icon {
          position: absolute;
          right: 10px;
          top: 50%;
          transform: translateY(-50%);
          cursor: pointer;
          font-size: 22px;
          color: #555;
          transition: 0.2s;
    }

   .visibility-icon:hover {
      color: #111;
   }
    @keyframes fadeIn {
      from { opacity:0; transform: translateY(20px); }
      to { opacity:1; transform: translateY(0); }
    }

    .anim-box {
      width:100%; height:360px; display:flex; align-items:center; justify-content:center;
    }

    lottie-player {
      width:100%; height:100%; max-height:360px;
    }

    .content h1 {
      margin:0 0 10px; font-size:30px; color:var(--accent);
      display:flex; align-items:center;
    }

    label {
      display:block; margin-top:12px; color:#374151; font-weight:bold;
    }

    input[type="text"], input[type="password"] {
      width:100%; padding:10px; margin-top:6px;
      border-radius:8px; border:1px solid #d1d5db;
      font-size:15px;
    }

    input[type="submit"] {
      width:100%; margin-top:22px; padding:12px;
      border:none; border-radius:8px;
      background:var(--accent); color:white; font-size:16px; font-weight:600;
      cursor:pointer; transition:0.2s;
    }

    input[type="submit"]:hover {
      background:#2563eb;
      transform: scale(1.03);
    }

    a { font-size:13px; color:#4f46e5; text-decoration:underline; margin-top:6px; display:block; }

    /* Animated gradient welcome text */
    #animatedText {
      opacity:0;
      font-size:22px;
      font-weight:bold;
      margin-bottom:10px;
      background: linear-gradient(90deg, #3b82f6, #8b5cf6, #ec4899);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      transition: all 1s ease;
      transfor margin:0;
  padding:0; m: translateY(20px);
    }

    #animatedText.show {
      opacity:1;
      transform: translateY(0);
      animation: bounce 0.8s ease;
    }

    @keyframes bounce {
      0% { transform: translateY(0); }
      30% { transform: translateY(-5px); }
      50% { transform: translateY(-10px); }
      70% { transform: translateY(-5px); }
      100% { transform: translateY(0); }
    }
  </style>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-player/1.4.3/lottie-player.min.js" defer></script>
</head>
<body>
  <div class="login-wrapper">
    <div class="card">

      <div class="anim-box">
        <lottie-player
          src="https://assets9.lottiefiles.com/packages/lf20_jcikwtux.json"
          background="transparent"Limited
          speed="1"
          loop autoplay>
        </lottie-player>
      </div>

      <div class="content">
        <h1>Welcome Back 👋</h1>
        <div id="animatedText">Login to continue your session</div>

        <form method="post" action="login" name="loginform">
          <label>Username
            <input type="text" name="USERNAME" required />
          </label>

          <label>Password
            <div class="password-wrapper">
              <input type="password" id="password" name="PASSWORD" required />
              <span id="togglePassword" class="material-icons visibility-icon">visibility</span>
            </div>
          </label>

          <a href="forgotPassword">Forgot Password?</a>

          <input type="submit" value="Login" />
          <input type="hidden" name="JavaScriptEnabled" value="Y" />
        </form>
      </div>

    </div>
  </div>

  <script>
    setTimeout(() => {
      const text = document.getElementById('animatedText');
      if (text) text.classList.add('show');
    }, 800);
  </script>
  <script>
    const togglePassword = document.getElementById("togglePassword");
    const password = document.getElementById("password");

    togglePassword.addEventListener("click", () => {
      const type = password.type === "password" ? "text" : "password";
      password.type = type;

      // Switch icon
      togglePassword.textContent =
        type === "password" ? "visibility" : "visibility_off";
    });
  </script>

</body>
</html>