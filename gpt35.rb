# frozen_string_literal: true

require 'openai'

OpenAI.configure do |config|
  config.access_token =  ''
  config.organization_id = ''
end

client = OpenAI::Client.new

dialog_messages = [
  { role: 'system',
    content: 'You are a terrific translator and gently point out the list of translations you have received from the customer. I will now ask you to do some checking of the translations. I will pair the original language with the translated text so you can check the translation. Your message will be Japanese.' },
  { role: 'system',
    content: 'As a prerequisite, please rate the accuracy and fluency of the translation on a scale from 0 to 100. In addition, specific suggestions for improvement and pointers will be given. The message may have some HTML tags. You need to ignore them.' },
]

source_lang = 'Japanese'
target_lang = 'English'

translations = [
  { id: '001', src: 'こんにちは', dst: 'Hello!' },
]

main_messages = translations.map do |t|
  { role: 'user', content: "id: #{t[:id]}, src: #{t[:src]}, dst: #{t[:dst]}" }
end

resp = client.chat(
  parameters: {
    model: 'gpt-3.5-turbo-0301',
    messages: [
      *dialog_messages,
      { role: 'user',
        content: "Source language is #{source_lang}, and Target language is #{target_lang}. I'll send pair of translations from next message." },
      *main_messages
    ]
  }
)

resp['choices'].map do |c|
  puts c['message']['content']
end
