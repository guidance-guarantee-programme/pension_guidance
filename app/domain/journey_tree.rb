require 'tree'

class JourneyTree
  include Singleton

  def tree
    @tree ||= six_steps_you_need_to_take
  end

  private

  def repository
    @repository ||= GuideRepository.new
  end

  def guide_node(slug)
    Tree::TreeNode.new(slug, repository.find(slug))
  end

  def six_steps_you_need_to_take
    guide_node('6-steps-you-need-to-take').tap do |node|
      node << pension_pot_value
      node << pension_pot_options
      node << making_money_last
      node << work_out_income
      node << tax
      node << shop_around
    end
  end

  def pension_pot_value
    guide_node('pension-pot-value')
  end

  def pension_pot_options
    guide_node('pension-pot-options').tap do |node|
      node << guide_node('leave-pot-untouched')
      node << guide_node('guaranteed-income')
      node << guide_node('adjustable-income')
      node << guide_node('take-cash')
      node << guide_node('mix-options')
    end
  end

  def making_money_last
    guide_node('making-money-last')
  end

  def work_out_income
    guide_node('work-out-income')
  end

  def tax
    guide_node('tax')
  end

  def shop_around
    guide_node('shop-around')
  end
end
