# frozen_string_literal: true

require 'openai'

OpenAI.configure do |config|
  config.access_token = ''
end

client = OpenAI::Client.new

directions = [
  { role: 'system',
    content: 'You are a terrific translator and gently point out following translations.
                I will give you a pair of the original language text and the translated text so you check the translation.
                As a prerequisite, please rate the accuracy and fluency of the translation on a scale from 0 to 100.
                If a term offensive to public order and morals is included, set fatal_error to true.
                If a proper noun contains an error, the accuracy score should be lowered by more.
                Also, set fatal_error to true.
                In addition, specific suggestions for improvement and pointers will be given.
                The message may have some HTML tags, then you need to ignore them.

                You return all evaluations as JSON format so that our system can read them.
                for example,
                {
                  \'fatal_error\': false,
                  \'accuracy_score\': 89,
                  \'fluency_score\': 90,
                  \'feedback_comment\': \'This translation is not wrong.\'
                }' }
]

src = '秋元真夏'
dst = 'Akimoto midsummer'

resp = client.chat(
  parameters: {
    model: 'gpt-3.5-turbo-0301',
    messages: [
      *directions,
      { role: 'user', content: "src: #{src}, dst: #{dst}" }
    ]
  }
)

resp['choices'].map do |c|
  puts c['message']['content']
end
