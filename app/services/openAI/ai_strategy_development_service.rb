# app/services/open_ai/ai_strategy_development_service.rb
module OpenAI
  class AiStrategyDevelopmentService
    def self.generate(section, business_idea)
      context = <<~CONTEXT
        Business Title: #{business_idea.title}
        Description: #{business_idea.description}
        Country: #{business_idea.country}

        Business Idea Summary:
        #{business_idea.business_idea_definition&.ai_summary}

        Market Research Insights:
        #{business_idea.market_research&.ai_suggestions}

        Competitor Summary:
        #{business_idea.competitor_analysis.last&.competitors&.map { |c| "#{c.name}: #{c.five_forces}" }&.join("\n\n")}
      CONTEXT

      prompt = if section == "core_strategy"
        <<~PROMPT
          Using the business context provided, generate a detailed "Core Strategy" for the startup, including:

          - SMART Strategic Goals (specific, measurable, achievable, relevant, time-bound)
          - Core strategic initiatives
          - Highlighted section labeled **Scaling Strategy**, focusing on how the business will grow, expand, or scale operations over time.

          Format Scaling Strategy like this:

          **Scaling Strategy:**
          - Detail 1
          - Detail 2
          ...

          Context:
          #{context}

          Return only the generated content.
        PROMPT
      else
        <<~PROMPT
          Using the business context provided, generate a detailed section for "#{section.humanize}" in a startup's strategic development plan.

          Context:
          #{context}

          Return only the generated content without explanation.
        PROMPT
      end

      OpenAiService.generate_text(prompt)
    end
  end
end
