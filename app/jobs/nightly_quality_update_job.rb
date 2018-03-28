class NightlyQualityUpdateJob < ApplicationJob
  def perform
    Item.find_each do |item|
      job_klass = case item.name
      when "Aged Brie"
        AgedBrieQualityUpdateJob
      when "Sulfuras, Hand of Ragnaros"
        SulfurasQualityUpdateJob
      when "Backstage pass to a TAFKAL80ETC concert"
        BackstagePassQualityUpdateJob
      when "Conjured Aged Brie"
      when "Conjured Sulfuras, Hand of Ragnaros"
      when /^Conjured backstage pass/i
      when /^Conjured/
        ConjuredItemQualityUpdateJob
      else
        ItemQualityUpdateJob
      end
      job_klass.perform_later(item)
    end
  end
end
