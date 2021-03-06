class Item < ActiveRecord::Base
  belongs_to :material
  belongs_to :requisicao

  validates_presence_of :qtd, :material_id
  validates_numericality_of :qtd

  def index
    requisicao.itens.index(self)
  end
end
