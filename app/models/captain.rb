class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where(classifications: {name: 'Catamaran'})
  end
  
  def self.sailors
    self.joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct
  end

  def self.talented_seamen
    seamen = self.joins(boats: :classifications).where(classifications: {name: 'Sailboat'}) & self.joins(boats: :classifications).where(classifications: {name: 'Motorboat'})
     self.where(id: seamen.map(&:id))
  end
  
  def self.non_sailors
    sailors = self.joins(boats: :classifications).where(classifications: {name: 'Sailboat'}).distinct 
    self.where(id: (self.all - self.sailors).map(&:id))
  end

end
