require "trading_day_jp/date"

module TradingDayJp

  def self.open?(date)
    date.trading_day_jp?
  end

  def self.next(date)
    loop do
      date = date + 1

      return date if date.trading_day_jp?
    end
  end

  def self.prev(date)
    loop do
      date = date - 1

      return date if date.trading_day_jp?
    end
  end

  def self.between(start, last)
    (start..last).select do |date|
      date.trading_day_jp?
    end
  end

  def self.beginning_of_month(date)
    date = Date.new(date.year, date.month)

    loop do
      return date if date.trading_day_jp?

      date = date + 1
    end
  end

  def self.end_of_month(date)
    date = Date.new(date.year, date.month).next_month - 1

    loop do
      return date if date.trading_day_jp?

      date = date - 1
    end
  end

  def self.beginning_of_month?(date)
    date == beginning_of_month(date)
  end

  def self.end_of_month?(date)
    date == end_of_month(date)
  end

  def self.beginning_of_year(date)
    self.next(Date.new date.year)
  end

  def self.end_of_year(date)
    prev beginning_of_year(Date.new(date.year + 1))
  end

  def self.beginning_of_year?(date)
    date == beginning_of_year(date)
  end

  def self.end_of_year?(date)
    date == end_of_year(date)
  end

  def self.beginning_of_quarters(date)
    year = date.year

    [ beginning_of_month(Date.new(year, 1)),
      beginning_of_month(Date.new(year, 4)),
      beginning_of_month(Date.new(year, 7)),
      beginning_of_month(Date.new(year, 10)) ]
  end

  def self.beginning_of_quarters?(date)
    beginning_of_quarters(date).include?(date)
  end

end
