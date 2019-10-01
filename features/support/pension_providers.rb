Around('@pension_providers') do |_, block|
  begin
    ENV['PENSION_PROVIDERS'] = '{"aviva":"Aviva"}'

    block.call
  ensure
    ENV.delete('PENSION_PROVIDERS')
  end
end
