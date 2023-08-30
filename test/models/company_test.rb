# frozen_string_literal: true

require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test 'valid company' do
    company = Company.new(document: '12.605.116/0001-19', legal_name: 'My Company', trade_name: 'Company')
    assert company.valid?
  end

  test 'invalid without document' do
    company = Company.new(legal_name: 'My Company', trade_name: 'Company')
    refute company.valid?
    assert_not_nil company.errors[:document]
  end

  test 'invalid without legal name' do
    company = Company.new(document: '12.605.116/0001-19', trade_name: 'Company')
    refute company.valid?
    assert_not_nil company.errors[:legal_name]
  end

  test 'invalid without trade name' do
    company = Company.new(document: '12.605.116/0001-19', legal_name: 'My Company')
    refute company.valid?
    assert_not_nil company.errors[:trade_name]
  end
end
