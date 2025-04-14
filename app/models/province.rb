class Province < ApplicationRecord
  has_many :customers

  def calculate_tax(total)
    gst = total * gst.to_f
    pst = total * pst.to_f
    hst = total * hst.to_f
    {
      gst: gst,
      pst: pst,
      hst: hst,
      total_tax: gst + pst + hst
    }
  end
end
