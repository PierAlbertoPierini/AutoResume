require 'classifier-reborn'

class ClassifyResume
  def initialize(resumes, training)
    @resumes = resumes
    @training = training

    train_classifier!
  end

  def classify!
    advertisements.each do |advertisement|
      StoreClassifications.new(advertisement, classifier).execute!
    end
  end

  private

  attr_reader :advertisements, :training

  def train_classifier!
    training.each do |t|
      classifier.add_item(t[:title], t[:category_id])
    end
  end

  def classifier
    @classifier ||= ClassifierReborn::LSI.new
  end
end

##TODO: implementation of a save data structure of the classifier
##TODO: read the data from a file
##TODO: decided how to train the classifier, data??
##TODO: 
##TODO:
