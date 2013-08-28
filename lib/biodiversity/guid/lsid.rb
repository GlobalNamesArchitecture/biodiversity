class LsidResolver
  def self.resolve(lsid)
    http_get_rdf(lsid)
  end
  
protected
  def self.http_get_rdf(lsid)
    rdf = ''
    open(Biodiversity::LSID_RESOLVER_URL + lsid) do |f|
      f.each do |line|
        rdf += line if !line.strip.blank?
      end
    end
    rdf
  end
end
