class CreateAudioTests < ActiveRecord::Migration[5.1]
  def change
    create_table :audio_tests do |t|

      t.timestamps
    end
  end
end
