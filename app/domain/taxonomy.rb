require 'tree'

class Taxonomy
  include Singleton

  def tree
    @tree ||= home.tap do |node|
      node << guide_node('living-abroad')
      node << guide_node('divorce')
      node << guide_node('protection')
      node << guide_node('already-bought-annuity')
      node << guide_node('pension_complaints')
    end
  end

  private

  def home
    home_node.tap do |node|
      node << your_pension_details
      node << taking_your_pension_money
      node << tax_and_getting_advice
      node << illness_and_death
    end
  end

  def your_pension_details
    category_node('your-pension-details').tap do |node|
      node << guide_node('pension-types')
      node << guide_node('pension-pot-value')
      node << guide_node('pension-statements')
      node << guide_node('state-pension')
    end
  end

  def taking_your_pension_money
    category_node('taking-your-pension-money').tap do |node|
      node << guide_node('making-money-last')
      node << guide_node('work-out-income')
      node << guide_node('your-pension-before-55')
      node << guide_node('scams')
      node << guide_node('shop-around')
      node << the_6_pension_options
    end
  end

  def the_6_pension_options
    guide_node('pension-pot-options').tap do |node|
      node << guide_node('leave-pot-untouched')
      node << guide_node('guaranteed-income')
      node << guide_node('adjustable-income')
      node << guide_node('take-cash-in-chunks')
      node << guide_node('take-whole-pot')
      node << guide_node('mix-options')
    end
  end

  def tax_and_getting_advice
    category_node('tax-and-getting-advice').tap do |node|
      node << guide_node('tax')
      node << guide_node('financial-advice')
      node << guide_node('benefits')
      node << guide_node('debt')
    end
  end

  def illness_and_death
    category_node('illness-and-death').tap do |node|
      node << guide_node('ill-health')
      node << guide_node('care-costs')
      node << guide_node('when-you-die')
    end
  end

  def category_repository
    @category_repository ||= CategoryRepository.new
  end

  def guide_repository
    @guide_repository ||= GuideRepository.new
  end

  def home_node
    Tree::TreeNode.new('home')
  end

  def category_node(slug)
    Tree::TreeNode.new(slug, category_repository.find(slug))
  end

  def guide_node(slug)
    Tree::TreeNode.new(slug, guide_repository.find(slug))
  end
end
