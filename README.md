# Emirates Demo — Einstein Bot Training Package

A sample Salesforce Einstein Bot package for use as a **bot-to-Agentforce migration training exercise**. Participants can use this bot as a starting point to practice migrating a real-world airline chatbot to an NGA (Next Generation AI) Agent using AgentScript.

## What's Included

| File | Description |
|------|-------------|
| `bots/emirates_demo.bot` | Einstein Bot metadata — dialogs, intents, navigation flows |
| `classes/Airline_Service_GetAirports.cls` | Invocable Apex: returns list of available airports |
| `classes/Airline_Service_GetFlights.cls` | Invocable Apex: returns available flights for a route |
| `classes/EmiratesCreateBooking.cls` | Invocable Apex: stub for creating a booking |
| `classes/EmiratesCancelBooking.cls` | Invocable Apex: stub for cancelling a booking |
| `classes/EmiratesFetchFlightStatus.cls` | Invocable Apex: stub for checking flight status |
| `package.xml` | Salesforce metadata manifest (API v65.0) |

## Bot Capabilities

The Emirates demo bot handles these conversation flows:

- **Flight Search** — ask for available airports and flights between two cities
- **Create Booking** — collect origin, destination, date, and passenger details; create a stub booking
- **Cancel Booking** — cancel an existing booking by ID (`booking_12345` is the demo booking)
- **Check Flight Status** — look up status for flights `FL001` or `FL002`
- **Career Applications** — routes to external career page
- **Merchandise** — routes to shopping catalog

> All Apex actions are **stubs** with hardcoded demo responses — no real airline API connections.

## Getting Started

### Prerequisites
- Salesforce CLI (`sf`) v2+
- A Salesforce Developer Org or Sandbox (API v65.0+)
- Einstein Bots enabled in the target org

### Deploy to Your Org

```bash
# Authenticate to your org
sf org login web --alias my-demo-org

# Deploy the Apex classes first
sf project deploy start --source-dir classes --target-org my-demo-org

# Deploy the bot
sf project deploy start --source-dir bots --target-org my-demo-org
```

Or deploy everything at once using the package manifest:

```bash
sf project deploy start --manifest package.xml --target-org my-demo-org
```

## Training Exercise: Migrate to Agentforce

This package is designed as the **source material** for a bot-to-Agentforce migration exercise. After deploying the Einstein Bot, the challenge is to migrate it to an NGA Agent backed by AgentScript.

### Exercise Goals

1. Analyze the bot dialogs and intents in `emirates_demo.bot`
2. Map each dialog flow to an AgentScript topic
3. Wire the existing Apex invocable actions to AgentScript `@actions`
4. Compile and deploy the resulting `.agent` file
5. Compare the conversation experience between the bot and the agent

### Key Mapping Patterns

| Einstein Bot Construct | AgentScript Equivalent |
|------------------------|------------------------|
| Intent | Topic trigger / `available when` |
| Dialog step (Message) | Reasoning instruction (`\| text`) |
| Dialog step (Invocation) | `call @actions.action_name` |
| Dialog step (Collect) | Slot-filling in reasoning |
| Navigation (Redirect) | `after_reasoning` transition |
| Navigation (Call) | `before_reasoning` action |
| Conversation variable | `mutable` variable |

## Notes

- Apex class `Airline_Service_GetAirports` includes airports from India, US, and Europe as demo data.
- `EmiratesCreateBooking` always returns `booking_id = booking_12345`.
- `EmiratesCancelBooking` only succeeds for `booking_id = booking_12345`.
- `EmiratesFetchFlightStatus` returns `available` for `FL001` and `FL002`, `unavailable` for all others.
