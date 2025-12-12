<#assign ctx = request.getContextPath() />

<!DOCTYPE html>
<html>
<head>
    <title>AI Help | Apache OFBiz</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <style>
        body {
            background: linear-gradient(135deg, #4b6cb7, #182848);
            padding: 20px;
            font-family: 'Poppins', sans-serif;
        }

        .ai-container {
            max-width: 1100px;
            margin: auto;
            display: grid;
            gap: 20px;
            grid-template-columns: 1fr 320px;
        }

        .glass-card {
            background: rgba(255,255,255,0.14);
            padding: 20px;
            border-radius: 16px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255,255,255,0.25);
        }

        #chat-window {
            height: 68vh;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .bubble {
            max-width: 80%;
            padding: 12px;
            border-radius: 10px;
            white-space: pre-wrap;
        }
        .user-msg { align-self: flex-end; background: #00c6ff33; color: white; }
        .ai-msg { align-self: flex-start; background: #ffffff22; color: #e6edff; }

        .chat-input {
            flex: 1;
            padding: 12px;
            background: rgba(255,255,255,0.20);
            border-radius: 10px;
            border: none;
            color: white;
        }

        .btn {
            background: #00c6ff;
            color: white;
            padding: 12px 14px;
            border-radius: 10px;
            border: none;
            cursor: pointer;
        }
        .btn:hover { background: #0072ff; }
    </style>
</head>

<body>

<div class="ai-container">

    <!-- Chat Section -->
    <section class="glass-card">

        <h2 style="color:white;margin-bottom:8px;">AI Help Assistant</h2>
        <small style="color:#cde3ff;">Ask anything about OFBiz setup, components, services, entities, UI, etc.</small>

        <div id="chat-window">
            <div class="bubble ai-msg">Hello! How can I help you?</div>
        </div>

        <form id="ai-form" style="display:flex; gap:10px; margin-top:15px;">
            <input id="ai-input" type="text" class="chat-input" placeholder="Type your question..." />
            <button class="btn" type="submit">Ask</button>
        </form>

        <div id="ai-status" style="color:white; margin-top:5px; font-size:13px;"></div>
    </section>

</div>


<script>
const chat = document.getElementById("chat-window");
const form = document.getElementById("ai-form");
const input = document.getElementById("ai-input");

function bubble(role, text){
    let div = document.createElement("div");
    div.className = "bubble " + (role === "user" ? "user-msg" : "ai-msg");
    div.textContent = text;
    chat.appendChild(div);
    chat.scrollTop = chat.scrollHeight;
}

form.addEventListener("submit", async (e) => {
    e.preventDefault();

    let q = input.value;
    if(!q) return;

    bubble("user", q);
    input.value = "";

    document.getElementById("ai-status").textContent = "Thinking...";

    let res = await fetch("${ctx}/aiHelpApi", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ question: q })
    });

    let data = await res.json();
    bubble("ai", data.answer || "No response.");
    document.getElementById("ai-status").textContent = "";
});
</script>

</body>
</html>
