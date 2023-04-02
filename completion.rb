# frozen_string_literal: true

require 'openai'

# Completion (not chat!)
class Completion
  def initialize(openai_token: nil, model: 'davinci')
    return if openai_token.nil?

    @client = OpenAI::Client.new(access_token: openai_token)
    @model = model
    @conversation = []
  end

  def create(content:)
    response = @client.completions(
      parameters: {
        model: @model,
        prompt: content
      }
    )
    puts response

    assistant_response = response['choices'][0]['text']
    @conversation.push(assistant_response)

    puts assistant_response
  end

  def show
    puts @conversation
  end
end
