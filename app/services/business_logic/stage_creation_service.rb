class BusinessLogic::StageCreationService
  def self.create_stages_for_business_idea(business_idea, selected_models)

    existing_models = business_idea.stages.distinct.pluck(:stage_type)

    # Determine models to add and remove
    models_to_add = selected_models - existing_models
    models_to_remove = existing_models - selected_models

    # Remove stages for deselected models
    business_idea.stages.where(stage_type: models_to_remove).destroy_all if models_to_remove.any?

    models_to_add.each do |model_type|
      stage_definitions = case model_type.to_sym
                          when :nine_stages
                            [
                              "Business Owner Characteristics",
                              "Business Idea Definition",
                              "Market Research",
                              "Competitor Analysis",
                              "Business Model Definition",
                              "Strategy Development",
                              "Financial Planning",
                              "Legal & Operations",
                              "Business Plan Finalization"
                            ]
                          when :lean_startup
                            [
                              "Build MVP",
                              "Measure & Learn",
                              "Validate Idea",
                              "Pivot if Necessary",
                              "Customer Feedback Loop",
                              "Iterations",
                              "Growth Hacking",
                              "Scaling Strategies",
                              "Expansion"
                            ]
                          when :business_model_canvas
                            [
                              "Key Partners",
                              "Key Activities",
                              "Value Propositions",
                              "Customer Segments",
                              "Channels",
                              "Revenue Streams",
                              "Cost Structure",
                              "Customer Relationships",
                              "Key Resources"
                            ]
                          when :bozward_model
                            [
                              "Discovery",
                              "Modeling",
                              "Startup",
                              "Existence",
                              "Survival",
                              "Success",
                              "Adaptation",
                              "Independence",
                              "Exit"
                            ]
                          end

      # Create Stages
      stage_definitions.each do |stage_name|
        stage = business_idea.stages.create!(
          name: stage_name, 
          stage_type: Stage.stage_types[model_type],
          status: :not_started
        )
        stage.stage_methods.create!(method_type: StageMethod.method_types[model_type])
      end
    end
  end
end
