module GroupHelpers
  def with_and_without_javascript(&block)
    feature 'with javascript' do
      metadata[:js] = true

      class_exec(&block)
    end

    feature 'without javascript' do
      metadata[:js] = false

      class_exec(&block)
    end
  end
end
