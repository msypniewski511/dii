# app/services/open_ai/context_builder_service.rb
module OpenAI
  class ContextBuilderService
    MAX_SECTION_LENGTH = 1000

    def self.build(business_idea, for_section)
      idea_summary = business_idea.business_idea_definition&.ai_summary&.truncate(MAX_SECTION_LENGTH)
      market_research = business_idea.market_research&.ai_suggestions&.truncate(MAX_SECTION_LENGTH)

      competitors = if %w[core_strategy strategic_goals].include?(for_section)
        business_idea
          .competitor_analysis
          &.last
          &.competitors
          &.limit(3)
          &.map { |c| "#{c.name}: #{c.five_forces&.truncate(300)}" }
          &.join("\n\n")
      end

      <<~CONTEXT
        Business Title: #{business_idea.title}
        Description: #{business_idea.description.truncate(MAX_SECTION_LENGTH)}
        Country: #{business_idea.country}

        Business Idea Summary:
        #{idea_summary}

        Market Research Insights:
        #{market_research}

        #{competitors ? "Competitor Summary:\n#{competitors}" : ""}
      CONTEXT
    end
  end
end
