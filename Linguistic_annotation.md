# Linguistic Markup Methods

*Research Focus:* Does the type of relationship that characters/groups have correlate with the particular pragmatic features used to convey an insult between them?

## Types of Relationships

### Gender
Do gender differences have any impact on insults?

**Markup:** `gender="male-male"`, a man insulting a man; `gender = '"male-female"` a man insulting a woman; `gender="female-female"` a woman insulting a woman; `gender="female-male"` a woman insulting a man.

### Relationship
Does the relationship between the characters have any bearing on the insult?

**Markup:** `rel="parent-child"` a parent insults their child; `rel="child-parent"` a child insults their parent; `rel="sibling-sibling"`, a siblings insults another sibling; and finally `rel="friend-friend"`, a friend insults a friend. If there ar insults occuring between a married couple; `rel="married-married"`. If aquaintances are insulting eachother; `rel="acquaintance-acquaintance"`. In the case of an insult where someone mocks themselves the markup is: `rel="self"`.

    *note*: Even though things could get more complex with questions such as : do they both consider themselves friends or is one 'undercover' or even if the person they are insulting is not present in the scene we will treat them all the same for simplicities sake.

### State of Relationships
Since things can get complicated, people aren't who they say they are and other such drama, classification of villains vs heroes is hard. So, we decided to have an attribute for the state of relationships between characters in order to gauge characters feelings for one another. 
This will enable us to look at the differences between insults among friends and enemies without having to classify characters in any grey areas. If the relationship state is negative there is animosity between them, if the relationship is positive there is goodwill and if they just met or have no real relationship the attribute value will be neutral. 
This can change over the course of the play, or even over the course of a small-scale dialogue, depending on the context.

**Markup:** `rel-state="neg"`; `rel-state="pos"`; `rel-state="neutral"`

## Types of Linguistic Features

### Speech Acts

#### Directness
Are the speech acts direct or indirect? A direct speech act is one where there is a direct correlation between the form and meaning of the utterance. In other words, there is no 'hidden' meaning that the listener could infer, what is said is what is meant.

**Markup** `speechAct='direct'`; `speechAct="indirect"`

#### Types of illocutionary acts
What illocutionary act is being committed by the speaker? Illocutionary acts are acts where there is more meaning there than is directly stated, which by definition means that all illocutionary acts are indirect.

**Markup:** `illoc-type="representative"` represents a state (i.e. suggesting, stating, describing); `illoc-type="directive"` instruct the listener to take an action (i.e. commanding, challenging); `illoc-type="commissive"` speaker commits to taking a future action (i.e. promising, threatening); `illoc-type="expressive"` express the speaker's mental state in relation to a state (i.e. thanking, welcoming, apologizing); `illoc-type="declarative"` to bring the state being referenced into reality (i.e. blessing, baptizing, sentencing)

### Grice's Maxims
What is being implied by the speaker in order to insult the recipient/are the typical rules of conversation (see Grice's Maxims: `https://www.sas.upenn.edu/~haroldfs/dravling/grice.html`) being violated in order to imply an insult?

**Markup:** `maxim="qual"` to give the most accurate information possible; `maxim="quant"` to give the most appropriate amount of information possible; `maxim="relev"` to give the most relevant information possible; `maxim="man"` to give the most clear, concise, and organized information as possible, avoiding ambiguity


  *Overall markup note:* All relevant attributes will be listed in the `insultStart` tag in the order they are listed here.
