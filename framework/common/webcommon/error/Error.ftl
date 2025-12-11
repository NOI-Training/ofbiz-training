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

<#if !visualTheme?has_content>
    <#assign visualTheme = Static["org.apache.ofbiz.widget.model.ThemeFactory"].resolveVisualTheme(null)/>
</#if>
<#if visualTheme?has_content>
    <#assign errorPageLocation = visualTheme.modelTheme.getErrorTemplateLocation('screen')/>
</#if>
<#if errorPageLocation?has_content>
    <#include visualTheme.modelTheme.getErrorTemplateLocation('screen')/>
<#else>
<html>
<head>
    <title>OFBiz Message</title><meta http-equiv="Content-Type" content="text/html">
</head>
<body bgcolor="#FFFFFF">
<div align="center">
    <h1>ERROR MESSAGE</h1>
    <hr>
    <p>${request.getAttribute('_ERROR_MESSAGE_')?replace("\n", "<br/>")}</p>
</div>
</body>
</html>
</#if>
-->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <title>Something went wrong</title>

  <meta name="viewport" content="width=device-width, initial-scale=1"/>

  <style>
    :root {
      --bg: #f7f8fb;
      --card: #ffffff;
      --muted: #6b7280;
      --accent: #ef4444;
    }
    html,body { height:100%; margin:0; font-family: Arial, sans-serif; background:var(--bg); color:#111827; }
    .error-wrapper {
      min-height:100vh;
      display:flex;
      align-items:center;
      justify-content:center;
      padding:24px;
    }
    .card {
      background:var(--card);
      border-radius:16px;
      box-shadow:0 10px 30px rgba(15,23,42,0.06);
      padding:28px;
      max-width:920px;
      width:100%;
      display:grid;
      grid-template-columns: 360px 1fr;
      gap:20px;
      align-items:center;
    }
    .anim-box, .fallback-img {
      width:100%;
      height:360px;
      display:flex;
      align-items:center;
      justify-content:center;
    }
    lottie-player { width:100%; height:100%; max-height:360px; }
    .content h1 { margin:0 0 10px; font-size:28px; color:var(--accent); display:flex; align-items:center; flex-wrap:wrap; }
    .content p { margin:0 0 12px; color:var(--muted); line-height:1.5; }
    .details { font-size:13px; color:#374151; background:#f3f4f6; padding:10px; border-radius:8px; word-break:break-word; }
    .actions { margin-top:14px; }
    .btn {
      display:inline-block; padding:8px 14px; border-radius:8px; text-decoration:none; font-weight:600;
      background:#111827; color:white;
    }
    @media (max-width:800px) {
      .card { grid-template-columns: 1fr; }
      .anim-box, .fallback-img { height:260px; }
    }

    /* Flying slipper animation */
    .flying-slipper {
      display: inline-block;
      position: relative;
      width: 30px;
      height: 30px;
      margin-left: 8px;
      animation: fly 2s linear infinite;
    }
    .flying-slipper img {
      width: 100%;
      height: 100%;
      display: block;
    }
    @keyframes fly {
      0% { transform: translateY(0) rotate(0deg); }
      25% { transform: translateY(-10px) rotate(15deg); }
      50% { transform: translateY(-20px) rotate(-15deg); }
      75% { transform: translateY(-10px) rotate(10deg); }
      100% { transform: translateY(0) rotate(0deg); }
    }
    #animatedText {
        opacity: 0;
        font-size: 24px;
        font-weight: bold;
        margin-top: 16px;
        margin-bottom: 10px;
        background: linear-gradient(90deg, #ef4444, #f97316, #3b82f6);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        transition: all 1s ease;
        transform: translateY(20px);
      }

      #animatedText.show {
        opacity: 1;
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

  <!-- lottie-player web component (cdn) -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/lottie-player/1.4.3/lottie-player.min.js" defer></script>
</head>
<body>
  <div class="error-wrapper">
    <div class="card" role="alert" aria-labelledby="errTitle">
      <div class="anim-box" aria-hidden="true">
        <lottie-player
          src="https://assets4.lottiefiles.com/packages/lf20_jcikwtux.json"
          background="transparent"
          speed="1"
          loop
          autoplay
          style="width:100%; height:100%;"
          alt="Error animation">
        </lottie-player>

        <div class="fallback-img" style="display:none;">
          <img id="fallbackGif" src="/images/error-fallback.gif" alt="Error animation" style="max-width:100%; max-height:100%; object-fit:contain;">
        </div>
      </div>
      <div class="content">
        <h1 id="errTitle">
          Oopsie! Something broke
          <span class="flying-slipper" aria-hidden="true">
            <img src="<@ofbizContentUrl>/warehouse-notes/images/error.png</@ofbizContentUrl>" alt="Error Icon" />
          </span>
        </h1>
        <div id="animatedText">Chill, we’re on it — the error won’t last long!</div>
        <p>We can't process your request right now. The server returned:</p>
        <div class="details">
            <p class="message">
                <#if request.getAttribute("_ERROR_MESSAGE_")?has_content>
                    ${request.getAttribute('_ERROR_MESSAGE_')?replace("\n", "<br/>")}
                <#else>
                    Something went wrong
                </#if>
            </p>
        </div>
        <div class="actions">
          <a href="${request.getContextPath()?default('/')}" class="btn">Go back to home</a>
        </div>
        <noscript>
          <p style="margin-top:10px; color:var(--muted)">JavaScript is disabled — showing image fallback.</p>
          <img src="/images/error-fallback.gif" alt="Error image" style="max-width:240px; display:block; margin-top:8px;">
        </noscript>
      </div>
    </div>
  </div>
  <script>
    // fallback to GIF if lottie fails
    window.addEventListener('DOMContentLoaded', function() {
      const player = document.querySelector('lottie-player');
      const fallback = document.querySelector('.fallback-img');

      if (!player || !player.getAttribute('src')) {
        if (player) player.style.display = 'none';
        if (fallback) fallback.style.display = 'flex';
        return;
      }

      let rendered = false;
      player.addEventListener('load', () => { rendered = true; });
      player.addEventListener('error', () => {
        player.style.display = 'none';
        fallback.style.display = 'flex';
      });

      setTimeout(() => {
        if (!rendered) {
          player.style.display = 'none';
          fallback.style.display = 'flex';
        }
      }, 3000);
    });
    setTimeout(() => {
        const text = document.getElementById('animatedText');
        if (text) {
          text.classList.add('show');
        }
      }, 1000);
  </script>
</body>
</html>