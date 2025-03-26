module OpenAI
  class BusinessIdeaDefinitionGenerator
    def initialize(definition)
      @definition = definition
      @idea = definition.business_idea
    end

    def generate(field)
      prompt = build_prompt_for(field)
      response = OpenAiService.generate_text(prompt)

      @definition.update(field => response.strip)
      response
    end

    private

    def build_prompt_for(field)
      <<~PROMPT
        Help me generate a clear and structured #{field.humanize.downcase} for this startup idea:

        Title: #{@idea.title}
        Description: #{@idea.description}
        Country: #{@idea.country}
        Industry: #{@idea.industry_type&.name || 'General'}

        Return only the #{field.humanize.downcase}, no headings.
      PROMPT
    end
  end
end
