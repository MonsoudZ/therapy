class FaqsController < ApplicationController
  def index
    @faqs = load_faqs
  end

  private

  def load_faqs
    [
      {
        question: "Do you accept insurance?",
        answer: "I am an out-of-network provider, which means I do not bill insurance directly. Many clients are able to use their out-of-network benefits to receive reimbursement for a portion of session costs. I can provide a monthly superbill for you to submit to your insurance."
      },
      {
        question: "How long is each session?",
        answer: "Standard sessions are 50 minutes. For EMDR and trauma-focused work, extended 75–90 minute sessions may be available depending on need."
      },
      {
        question: "What can I expect in the first session?",
        answer: "Our first meeting will focus on your goals, history, and what brought you to therapy. We will discuss your needs and begin to develop a plan together, while also making sure you feel comfortable with my approach."
      },
      {
        question: "How often will we meet?",
        answer: "Most clients begin with weekly sessions. As progress is made, we may shift to bi-weekly or monthly check-ins depending on your goals and needs."
      },
      {
        question: "What issues can therapy help with?",
        answer: "I work with individuals facing anxiety, depression, trauma, grief, relationship challenges, and life transitions. I also provide support for couples and offer supervision for clinicians."
      }
    ]
  end
end
