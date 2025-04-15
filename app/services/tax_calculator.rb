module TaxCalculator
  def self.calculate_tax(total, province)
    gst = (total * province.gst.to_f).round(2)
    pst = (total * province.pst.to_f).round(2)
    hst = (total * province.hst.to_f).round(2)

    {
      gst: gst,
      pst: pst,
      hst: hst,
      total_tax: (gst + pst + hst).round(2)
    }
  end
end
