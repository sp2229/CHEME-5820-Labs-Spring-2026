"""
    generate_quantumbrew_reviews(; n_per_class=250, seed=42) -> DataFrame

Generate synthetic product reviews for QuantumBrew Coffee with three sentiment classes:
positive, negative, and neutral. Returns a shuffled DataFrame with columns :review and :label.
"""
function generate_quantumbrew_reviews(; n_per_class::Int=250, seed::Int=42)::DataFrame

    rng = MersenneTwister(seed)
    flavors = ["Classic Espresso Surge", "Vanilla Lightning", "Caramel Thunder",
               "Mocha Bolt", "Hazelnut Shock"]

    # --- positive templates ---
    pos_openers = [
        "QuantumBrew is hands down the best energy coffee I have ever tried.",
        "I am completely hooked on QuantumBrew.",
        "Five stars for QuantumBrew, this product delivers.",
        "QuantumBrew has replaced my morning espresso and my afternoon energy drink.",
        "I bought QuantumBrew on a whim and now I can not go without it.",
        "If you need a serious caffeine boost with great flavor then QuantumBrew is it.",
        "QuantumBrew lives up to the hype and then some.",
        "I have tried dozens of energy coffees and QuantumBrew is the clear winner.",
        "I absolutely love QuantumBrew.",
        "QuantumBrew is exactly what I have been looking for in an energy coffee.",
        "My whole office is obsessed with QuantumBrew now.",
        "I never thought an energy coffee could taste this good.",
    ]
    pos_bodies = [
        "The FLAVOR flavor is rich and smooth without any bitterness.",
        "It gives me a clean energy boost that lasts for hours without the crash.",
        "The balance between espresso flavor and energy ingredients is perfect.",
        "I drink one every morning and it keeps me focused all day.",
        "The taste is surprisingly good for an energy coffee.",
        "It has a bold coffee flavor that actually tastes like real espresso.",
        "No jitters, no crash, just steady energy and great taste.",
        "The FLAVOR is my favorite and I order it by the case now.",
        "It mixes great with milk for a smooth latte-style energy drink.",
        "The caffeine content is well balanced, enough to feel it but not overwhelming.",
        "The FLAVOR has a depth of flavor that keeps me coming back.",
        "Every sip delivers the perfect combination of energy and espresso quality.",
    ]
    pos_closers = [
        "Highly recommend to anyone who loves coffee and needs an energy boost.",
        "Will definitely keep buying this.",
        "Best purchase I have made in a long time.",
        "I recommend it to all my coworkers.",
        "Can not imagine my mornings without it now.",
        "Worth every penny.",
        "I have already recommended it to everyone I know.",
        "This is the only energy coffee I will buy from now on.",
        "Do yourself a favor and try this.",
        "A must-have for any coffee lover.",
    ]

    # --- negative templates ---
    neg_openers = [
        "I was really disappointed with QuantumBrew.",
        "QuantumBrew was a complete waste of money.",
        "I do not understand the hype around QuantumBrew at all.",
        "Tried QuantumBrew and immediately regretted it.",
        "QuantumBrew is one of the worst energy coffees I have tried.",
        "Save your money and avoid QuantumBrew.",
        "I wanted to like QuantumBrew but it was terrible.",
        "Very disappointed with this product overall.",
        "QuantumBrew is not worth the premium price.",
        "I will not be buying QuantumBrew again after this experience.",
        "This was a terrible purchase.",
        "I had high hopes for QuantumBrew but it let me down.",
    ]
    neg_bodies = [
        "The FLAVOR flavor tastes artificial and leaves a bad aftertaste.",
        "It gave me terrible jitters and an awful crash after two hours.",
        "The taste is bitter and chemical, nothing like real espresso.",
        "I felt nauseous after drinking just half a can.",
        "The energy boost was minimal and the taste was unpleasant.",
        "It tastes like burnt coffee mixed with something medicinal.",
        "Way too sweet and the coffee flavor is barely noticeable.",
        "It upset my stomach and the energy did not last at all.",
        "The FLAVOR flavor is overwhelming and unnatural.",
        "After trying the FLAVOR I could not finish the can.",
        "The aftertaste lingers and is genuinely unpleasant.",
        "It made me feel worse than before I drank it.",
    ]
    neg_closers = [
        "Would not recommend this to anyone.",
        "Total waste of money.",
        "I threw out the rest of the pack.",
        "Going back to regular espresso after this.",
        "I wish I could get a refund.",
        "There are much better options out there for less money.",
        "Save yourself the trouble and skip this one.",
        "One of my worst purchases this year.",
        "Avoid this product.",
        "I regret spending money on this.",
    ]

    # --- neutral templates ---
    neu_openers = [
        "QuantumBrew is an okay energy coffee.",
        "My experience with QuantumBrew was mixed overall.",
        "QuantumBrew is decent but nothing special.",
        "I have mixed feelings about QuantumBrew.",
        "QuantumBrew is fine for what it is.",
        "Not bad and not great, just average.",
        "QuantumBrew gets the job done.",
        "I tried QuantumBrew and it was alright.",
        "QuantumBrew is a standard energy coffee product.",
        "There is nothing particularly wrong or right with QuantumBrew.",
        "QuantumBrew is a middle of the road energy coffee.",
        "I picked up QuantumBrew to try something different.",
    ]
    neu_bodies = [
        "The FLAVOR flavor is acceptable but not memorable.",
        "The energy boost is moderate and wears off after a couple hours.",
        "It tastes like a typical energy coffee, nothing more and nothing less.",
        "The flavor is tolerable but I would not call it good or bad.",
        "It works as a caffeine source but the taste is just average.",
        "Some flavors are better than others but none really stand out.",
        "The energy effect is comparable to a regular cup of coffee.",
        "It is overpriced for what you get but the quality is consistent.",
        "The taste is passable and the energy boost is noticeable.",
        "It does what it says but there are other options in this price range.",
        "The FLAVOR is fine but I have had better from other brands.",
        "The caffeine hits but the flavor does not leave much of an impression.",
    ]
    neu_closers = [
        "I might buy it again if nothing else is available.",
        "It is neither my first choice nor my last.",
        "Take it or leave it.",
        "An acceptable option if you want to try something different.",
        "I would give it a try but do not expect too much.",
        "It is just okay.",
        "Not something I would go out of my way to buy.",
        "Decent enough for an occasional purchase.",
        "It fills a gap but does not stand out.",
        "An average product in a crowded market.",
    ]

    reviews = String[]
    labels = String[]

    for templates in [(pos_openers, pos_bodies, pos_closers, "positive"),
                      (neg_openers, neg_bodies, neg_closers, "negative"),
                      (neu_openers, neu_bodies, neu_closers, "neutral")]

        openers, bodies, closers, label = templates
        for _ in 1:n_per_class
            flavor = rand(rng, flavors)
            opener = rand(rng, openers)
            body = replace(rand(rng, bodies), "FLAVOR" => flavor)
            closer = rand(rng, closers)
            push!(reviews, "$opener $body $closer")
            push!(labels, label)
        end
    end

    # shuffle the dataset
    idx = shuffle(rng, 1:length(reviews))
    return DataFrame(review = reviews[idx], label = labels[idx])
end
