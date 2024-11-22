class Article < ApplicationRecord
  has_one_attached :audio

  before_save :generate_audio_mp3

  private

  def generate_audio_mp3
    response = TextToSpeech.new.speech(self.content)
    self.audio.attach(
      io: StringIO.new(response, 'rb'),
      filename: audio_filename
    )
  end

  def audio_filename
    "article-#{id}.mp3"
  end
end
