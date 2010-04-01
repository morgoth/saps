# encoding: UTF-8

class ChangePlayerPositionName < ActiveRecord::Migration
  def self.up
    Player.update_all("position = 'setter'", "position = 'Rozgrywający'")
    Player.update_all("position = 'attacker'", "position = 'Atakujący'")
    Player.update_all("position = 'hitter'", "position = 'Przyjmujący'")
    Player.update_all("position = 'libero'", "position = 'Libero'")
    Player.update_all("position = 'blocker'", "position = 'Środkowy'")
  end

  def self.down
    Player.update_all("position = 'Rozgrywający'", "position = 'setter'")
    Player.update_all("position = 'Atakujący'", "position = 'attacker'")
    Player.update_all("position = 'Przyjmujący'", "position = 'hitter'")
    Player.update_all("position = 'Libero'", "position = 'libero'")
    Player.update_all("position = 'Środkowy'", "position = 'blocker'")
  end
end
