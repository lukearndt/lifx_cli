require 'lifx'

module Lights
  class TagNotFound < StandardError; end
  extend self

  def [](tag)
    discover
    LIFX::Client.lan.lights.with_tag(tag)
  rescue LIFX::LightCollection::TagNotFound
    raise TagNotFound
  end

  def all
    discover
    LIFX::Client.lan.lights
  end

  def with_label(label)
    LIFX::Client.lan.discover! do |c|
      c.lights.with_label(label)
    end.lights.with_label(label)
  end

  def with_id(id)
    LIFX::Client.lan.discover! do |c|
      c.lights.with_id(id)
    end.lights.with_id(id)
  end

  private

  def discover
    LIFX::Client.lan.discover unless @discovered_already
    sleep(3)
    @discovered_already = true
  end
end
