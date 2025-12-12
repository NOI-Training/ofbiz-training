package script.test.org

import groovy.json.JsonOutput
import groovy.json.JsonSlurper


def run(context) {

    String question = context.question ?: "No question provided."

    def apiUrl = "https://openrouter.ai/api/v1/chat/completions"
    def apiKey = System.getenv("OPENROUTER_KEY")

    if (!apiKey) {
        return [answer: "ERROR: OPENROUTER_KEY environment variable not set."]
    }

    def payload = [
            model: "qwen/qwen-2.5-7b-instruct",
            messages: [
                    [role: "system", content: "You are an OFBiz expert assistant. Answer clearly."],
                    [role: "user",   content: question]
            ]
    ]

    try {
        def conn = new URL(apiUrl).openConnection()
        conn.setRequestMethod("POST")
        conn.setDoOutput(true)
        conn.setRequestProperty("Content-Type", "application/json")
        conn.setRequestProperty("Authorization", "Bearer ${apiKey}")

        conn.outputStream.withWriter("UTF-8") { w ->
            w.write(JsonOutput.toJson(payload))
        }

        def jsonResp = new JsonSlurper().parse(conn.inputStream)
        def answer = jsonResp?.choices?.getAt(0)?.message?.content ?: "No AI response."

        return [answer: answer]

    } catch (Exception e) {
        return [answer: "AI error: ${e.message}"]
    }
}

