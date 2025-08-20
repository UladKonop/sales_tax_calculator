require_relative '../lib/exemption_checker'
describe ExemptionChecker do
  describe '.exempt?' do
    it 'identifies books as exempt' do
      expect(ExemptionChecker.exempt?('book')).to be true
      expect(ExemptionChecker.exempt?('Book of stories')).to be true
    end
    it 'identifies chocolate as exempt' do
      expect(ExemptionChecker.exempt?('chocolate bar')).to be true
      expect(ExemptionChecker.exempt?('box of chocolates')).to be true
    end
    it 'identifies pills as exempt' do
      expect(ExemptionChecker.exempt?('headache pills')).to be true
      expect(ExemptionChecker.exempt?('packet of pills')).to be true
    end
    it 'identifies non-exempt products' do
      expect(ExemptionChecker.exempt?('music CD')).to be false
      expect(ExemptionChecker.exempt?('perfume')).to be false
    end
  end
end
