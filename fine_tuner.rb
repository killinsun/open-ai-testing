# frozen_string_literal: true

require 'openai'

# Fine tune
class FineTuner
  def initialize(openai_token: nil)
    return if openai_token.nil?

    @client_files = OpenAI::Files.new(access_token: openai_token)
    @client_finetunes = OpenAI::Finetunes.new(access_token: openai_token)
  end

  def upload_fine_tune_file
    response = @client_files.upload(parameters: { file: './data_prepared.jsonl', purpose: 'fine-tune' })
    puts response
  end

  def create_fine_tune(file_id:, base_model: 'davinci')
    response = @client_finetunes.create(parameters: { training_file: file_id, model: base_model })
    puts response
  end

  def list_fine_tunes
    response = @client_finetunes.list
    puts response
  end

  def list_files
    response = @client_files.list
    puts response
  end
end
