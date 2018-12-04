class XmlController < ApplicationController
  include Math
  before_action :parse_params, only: :index

  def index
    if !@input_is_ok
      @result = 'ОШИБКА: недопустимый ввод'
    else
      begin
        @correct = Array[]
        @count = 0
        factorial = 1
        i = 1

        @max.times do
          factorial *= i
          root = cbrt(factorial).round
          if factorial == root * (root - 1) * (root + 1)
            @count += 1
            @correct.push((root - 1).to_s + '*' + root.to_s + '*' + (root + 1).to_s + '=' + i.to_s + '!')
          end
          i += 1
        end

        @result = @count == 4 ? 'Гипотеза Симона выполняется' : 'Гипотеза Симона не выполняется'
      rescue FloatDomainError
        @result = 'ОШИБКА: последнее рассчитанное значение ' + (i-1).to_s + '!' + ' дальнейшие расчёты невозможны - недостаточно памяти'
      end
    end

    data = { message: @result, content: @correct.map { |elem| { fact: elem } } }

    respond_to do |format|
      format.xml{ render xml: data.to_xml }
      format.rss{ render xml: data.to_xml }
    end
  end

  protected

  def parse_params
    @input_is_ok = true
    begin
      # If params[:max]=nil then Integer(nil) throws the exception too
      @max = Integer(params[:max])
      @input_is_ok = false if @max.negative?
    rescue TypeError, ArgumentError
      @input_is_ok = false
    end
  end

end
