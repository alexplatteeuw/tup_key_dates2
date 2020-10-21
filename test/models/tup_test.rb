require 'test_helper'

class TupTest < ActiveSupport::TestCase
  # tups.sort_by! { |tup| Date.parse(tup[:publication]) }
  def setup
    @tups = [
            {:publication=>"27/09/2018", :start=>"28/09/2018", :end=>"29/10/2018", :legal_effect=>"30/10/2018"},
            {:publication=>"28/09/2018", :start=>"29/09/2018", :end=>"29/10/2018", :legal_effect=>"30/10/2018"},
            {:publication=>"29/09/2018", :start=>"30/09/2018", :end=>"29/10/2018", :legal_effect=>"30/10/2018"}, 
            {:publication=>"01/10/2018", :start=>"02/10/2018", :end=>"31/10/2018", :legal_effect=>"01/11/2018"}, 
            {:publication=>"30/10/2018", :start=>"31/10/2018", :end=>"29/11/2018", :legal_effect=>"30/11/2018"}, 
            {:publication=>"31/10/2018", :start=>"01/11/2018", :end=>"30/11/2018", :legal_effect=>"01/12/2018"}, 
            {:publication=>"28/11/2018", :start=>"29/11/2018", :end=>"28/12/2018", :legal_effect=>"29/12/2018"}, 
            {:publication=>"30/11/2018", :start=>"01/12/2018", :end=>"31/12/2018", :legal_effect=>"01/01/2019"}, 
            {:publication=>"27/02/2019", :start=>"28/02/2019", :end=>"29/03/2019", :legal_effect=>"30/03/2019"}, 
            {:publication=>"01/03/2019", :start=>"02/03/2019", :end=>"01/04/2019", :legal_effect=>"02/04/2019"}, 
            {:publication=>"29/03/2019", :start=>"30/03/2019", :end=>"29/04/2019", :legal_effect=>"30/04/2019"}, 
            {:publication=>"01/04/2019", :start=>"02/04/2019", :end=>"02/05/2019", :legal_effect=>"03/05/2019"}, 
            {:publication=>"29/04/2019", :start=>"30/04/2019", :end=>"29/05/2019", :legal_effect=>"30/05/2019"}, 
            {:publication=>"30/04/2019", :start=>"01/05/2019", :end=>"31/05/2019", :legal_effect=>"01/06/2019"}, 
            {:publication=>"29/05/2019", :start=>"30/05/2019", :end=>"28/06/2019", :legal_effect=>"29/06/2019"}, 
            {:publication=>"31/05/2019", :start=>"01/06/2019", :end=>"01/07/2019", :legal_effect=>"02/07/2019"}, 
            {:publication=>"30/09/2019", :start=>"01/10/2019", :end=>"30/10/2019", :legal_effect=>"31/10/2019"}, 
            {:publication=>"01/10/2019", :start=>"02/10/2019", :end=>"31/10/2019", :legal_effect=>"01/11/2019"}, 
            {:publication=>"30/10/2019", :start=>"31/10/2019", :end=>"29/11/2019", :legal_effect=>"30/11/2019"}, 
            {:publication=>"31/10/2019", :start=>"01/11/2019", :end=>"02/12/2019", :legal_effect=>"03/12/2019"},
            {:publication=>"27/11/2019", :start=>"28/11/2019", :end=>"27/12/2019", :legal_effect=>"28/12/2019"},
            {:publication=>"28/11/2019", :start=>"29/11/2019", :end=>"30/12/2019", :legal_effect=>"31/12/2019"},
            {:publication=>"29/11/2019", :start=>"30/11/2019", :end=>"30/12/2019", :legal_effect=>"31/12/2019"}, 
            {:publication=>"30/11/2019", :start=>"01/12/2019", :end=>"30/12/2019", :legal_effect=>"31/12/2019"},
            {:publication=>"02/12/2019", :start=>"03/12/2019", :end=>"02/01/2020", :legal_effect=>"03/01/2020"},
            {:publication=>"31/12/2019", :start=>"01/01/2020", :end=>"30/01/2020", :legal_effect=>"31/01/2020"},
            {:publication=>"02/01/2020", :start=>"03/01/2020", :end=>"03/02/2020", :legal_effect=>"04/02/2020"},
            {:publication=>"29/01/2020", :start=>"30/01/2020", :end=>"28/02/2020", :legal_effect=>"29/02/2020"},
            {:publication=>"31/01/2020", :start=>"01/02/2020", :end=>"02/03/2020", :legal_effect=>"03/03/2020"},
            {:publication=>"28/02/2020", :start=>"29/02/2020", :end=>"30/03/2020", :legal_effect=>"31/03/2020"},
            {:publication=>"02/03/2020", :start=>"03/03/2020", :end=>"01/04/2020", :legal_effect=>"02/04/2020"}
          ]
      end
        
    test "dates computed from publication should be correct" do
      @tups.each do |given_tup|
        day = Day.parse(given_tup[:publication]).find_dates_from_publication
        tup = Tup.create(day)
        assert_equal(given_tup[:publication], tup.publication.strftime("%d/%m/%Y"))
        assert_equal(given_tup[:start], tup.opposition_start.strftime("%d/%m/%Y"))
        assert_equal(given_tup[:end], tup.opposition_end.strftime("%d/%m/%Y"))
        assert_equal(given_tup[:legal_effect], tup.legal_effect.strftime("%d/%m/%Y"))
      end
   end
   
    test "dates computed from legal effect should be correct" do
      
      def find_publications(legal_effect)
        publications = []
        @tups.each { |tup| publications << tup[:publication] if tup[:legal_effect] == legal_effect }
        publications.sort
      end
      
      @tups.each do |given_tup|
        p "given tup: #{given_tup}"
        day = Day.parse(given_tup[:legal_effect]).find_dates_from_legal_effect
        p "day with publications : #{day}"
        day[:publication] = day[:publications].sample
        day.delete(:publications)
        p "day with sampled publication : #{day}"
        tup = Tup.create(day)
        p "tup : #{tup}"
        
        assert_includes(find_publications(given_tup[:legal_effect]), tup.publication.strftime("%d/%m/%Y"))
        assert_equal(given_tup[:end], tup.opposition_end.strftime("%d/%m/%Y"))
        assert_equal(given_tup[:legal_effect], tup.legal_effect.strftime("%d/%m/%Y"))
      end
   end
end
