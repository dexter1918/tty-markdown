# frozen_string_literal: true

RSpec.describe TTY::Markdown, "typography" do
  let(:symbols) { TTY::Markdown::SYMBOLS }

  it "converts header with typographic symbols" do
    markdown =<<-TEXT
--- << typographic >> ... symbols --
    TEXT
    parsed = TTY::Markdown.parse(markdown, symbols: :unicode)
    expect(parsed).to eq("#{symbols[:mdash]} #{symbols[:laquo]} typographic #{symbols[:raquo]} #{symbols[:hellip]} symbols #{symbols[:ndash]}\n")
  end

  it "converts smart quotes to utf-8 chars" do
    markdown = "To \"extract\" `script.rb`'s..."
    parsed = TTY::Markdown.parse(markdown, mode: 16, symbols: :unicode)

    expect(parsed).to eq("To #{symbols[:ldquo]}extract#{symbols[:rdquo]} \e[33mscript.rb\e[0m#{symbols[:rsquo]}s#{symbols[:hellip]}\n")
  end
end
