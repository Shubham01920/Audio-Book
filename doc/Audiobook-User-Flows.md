# COMPREHENSIVE USER FLOWS & NAVIGATION MAP
## Complete User Journey & Page Connection Architecture
**Document Version:** 1.0  
**Date:** December 26, 2025  
**Total User Flows:** 18 Core Flows + 12 Edge Case Flows

---

## TABLE OF CONTENTS
1. Navigation Architecture Overview
2. User Flow Diagrams (18 Core Flows)
3. Page Connection Map (Adjacency Matrix)
4. User Personas & Their Journeys
5. Navigation Patterns & Best Practices
6. Edge Cases & Error Flows
7. Deep Linking Strategy
8. Bottom Navigation Behavior

---

## SECTION 1: NAVIGATION ARCHITECTURE OVERVIEW

### App Structure Hierarchy

```
ROOT: App Launch (Page 1: Splash Screen)
│
├─ NOT AUTHENTICATED
│  ├─ Page 2: Welcome Screen
│  ├─ Page 3: Sign Up / Login
│  └─ Page 4: Preferences Setup
│
└─ AUTHENTICATED
   ├─ MAIN NAVIGATION (Bottom Nav - 5 Tabs)
   │  ├─ [HOME TAB]
   │  │  ├─ Page 5: Home / Dashboard
   │  │  ├─ Page 6: Discover / Browse
   │  │  ├─ Page 7: Emotional Search Results
   │  │  ├─ Page 8: Samples / Trailers Feed
   │  │  ├─ Page 9: Countdown Pages / Upcoming
   │  │  └─ Page 19: Series Grouping & Detail
   │  │
   │  ├─ [SEARCH TAB]
   │  │  ├─ Page 20: Search / Explore Page
   │  │  ├─ Page 21: Advanced Search Filters
   │  │  ├─ Page 22: Search Results
   │  │  └─ Page 23: Author / Narrator Detail
   │  │
   │  ├─ [LIBRARY TAB]
   │  │  ├─ Page 14: My Library (Main)
   │  │  ├─ Page 15: Library Filters Modal
   │  │  ├─ Page 16: Create/Manage Shelves
   │  │  ├─ Page 17: Wishlist / Want to Read
   │  │  ├─ Page 18: Reading Log / Stats
   │  │  ├─ Page 50: My Downloads
   │  │  └─ Page 51: Saved Bookmarks & Passages
   │  │
   │  ├─ [SOCIAL TAB]
   │  │  ├─ Page 24: Social / Community Hub
   │  │  ├─ Page 25: Book Clubs
   │  │  ├─ Page 26: Live Discussion / Story Circle
   │  │  ├─ Page 27: Share Audio Clip Modal
   │  │  ├─ Page 28: Reading Challenge
   │  │  ├─ Page 29: Review & Rating
   │  │  └─ Page 30: Follow / Recommendations
   │  │
   │  └─ [ACCOUNT TAB]
   │     ├─ Page 48: User Profile / Account Home
   │     ├─ Page 49: Edit Profile
   │     ├─ Page 38: Accessibility Settings
   │     ├─ Page 39: Display & Theme Settings
   │     ├─ Page 40: Notification Settings
   │     ├─ Page 41: Privacy & Data Settings
   │     ├─ Page 42: App Settings
   │     ├─ Page 43: Language & Region Settings
   │     ├─ Page 44: Family Account / Family Sharing
   │     ├─ Page 45: Kids Mode / Parental Controls
   │     ├─ Page 46: Kids Content Library
   │     ├─ Page 47: Child Profile / Activity Dashboard
   │     ├─ Page 52: Notification Center
   │     ├─ Monetization Section (Pages 31-37):
   │     │  ├─ Page 31: Pricing / Subscription Plans
   │     │  ├─ Page 32: Payment Method / Billing Details
   │     │  ├─ Page 33: Billing History / Invoice
   │     │  ├─ Page 34: Promotional / Gift Code
   │     │  ├─ Page 35: Free Trial Confirmation
   │     │  ├─ Page 36: Manage Subscription
   │     │  └─ Page 37: Referral Rewards Program
   │     └─ Log Out
   │
   └─ MODAL / OVERLAY LAYER (On top of current screen)
      ├─ Modal 1: Genre/Category Selection
      ├─ Modal 2: Share Book
      ├─ Modal 3: Rate & Review
      ├─ Modal 4: More Options / Context Menu
      ├─ Modal 5: Add to Shelf / Favorites
      ├─ Modal 6: Playback Settings / EQ Presets
      ├─ Modal 7: Narrator/Voice Selection
      ├─ Modal 8: Content Rating / Age Filter
      ├─ Modal 9: Error / Network Issue
      ├─ Modal 10: Feature Unlock / Paywall
      ├─ Modal 11: Confirmation Modal
      ├─ Modal 12: Advanced Search Filters
      ├─ Player Modal: Page 10 (Full Player Expanded)
      ├─ Mini Player: Page 11 (Fixed at Bottom)
      ├─ Bookmarks Panel: Page 13 (Side Panel/Modal)
      └─ Car Mode: Page 12 (Full Screen, No Bottom Nav)

```

---

## SECTION 2: CORE USER FLOWS (18 Flows)

### FLOW 1: New User Onboarding & First Listen

```
START: App Launch
   ↓
PAGE 1: Splash Screen (2-3 sec auto-redirect)
   ↓
PAGE 2: Welcome Screen
   └─ Carousel of 4 key features
   └─ "Continue with Email" → PAGE 3
   └─ "Continue with Google/Apple/Facebook" → PAGE 3 (auto-fill)
   ↓
PAGE 3: Sign Up / Login
   └─ Email + Password input
   └─ Two-Factor Auth (optional)
   └─ "Sign Up" button → PAGE 4
   └─ "Forgot Password?" → Password Reset Flow (not shown)
   ↓
PAGE 4: Preferences / Account Setup
   └─ Language selection (English / Hindi / Tamil / etc.)
   └─ Region selection (India / USA / UK / etc.)
   └─ Monetization model choice (Credits / Unlimited / Free with Ads)
   └─ Content preferences (Fiction / Non-Fiction / Kids / etc.)
   └─ Accessibility toggles
   └─ Age confirmation
   └─ "Continue to Home" → PAGE 5
   ↓
PAGE 5: Home / Dashboard
   ↓ [First-Time UX: Show onboarding tips]
   └─ "Personalized Recommendations" section (empty - suggest browsing)
   └─ Genre shortcuts → PAGE 6 (Discover)
   └─ OR Search → PAGE 20
   └─ OR Bottom Nav [Home] (already here)
   ↓
PAGE 6: Discover / Browse
   └─ Browse featured collections
   └─ Tap book cover → FLOW 2 (Book Detail & Listen)
   └─ OR Tap genre → PAGE 6 (filtered view)
   └─ OR Tap "Top Lists" → Show Top 20/50 books
   ↓
FLOW 2: Book Detail Page (Not explicitly listed, but implied)
   └─ Book cover, title, author, narrator, synopsis
   └─ "Listen Free Sample" button → PAGE 8 (sample plays inline)
   └─ OR "Start Listening" button → PAGE 10 (Player opens)
   └─ OR "Add to Wishlist" button → PAGE 17 (saved)
   └─ OR "Add to [Shelf]" button → Modal 5
   ↓
PAGE 10: Full Player
   └─ [User listens to first audiobook]
   └─ Playback controls: Play/Pause, Speed, Volume, Sleep Timer
   └─ Progress bar, chapter list, transcript (if enabled)
   └─ Bookmark button → PAGE 13 (Bookmarks Panel opens as overlay)
   └─ Back arrow (minimize) → Returns to previous screen with PAGE 11 (mini-player at bottom)
   ↓
END: User establishes listening habit → Streak begins (Gamification integration)
```

**Conversion Point:** "Continue Listening" → Opens player at same timestamp next time

---

### FLOW 2: Book Discovery & Purchase

```
START: User wants to find a new book
   ↓
PAGE 5: Home / Dashboard
   └─ Option A: Tap "Recommended for You" carousel → Book detail
   └─ Option B: Tap "Trending Now" → See trending books
   └─ Option C: Tap genre shortcut (Fiction, Self-Help, etc.) → PAGE 6
   └─ Option D: Use search → PAGE 20
   ↓
[Option A/B/C: Browse discovery pages]
   ↓
PAGE 6: Discover / Browse
   └─ Carousel of collections
   └─ Spotlight featured book
   └─ Microgenre tags cloud
   └─ Tap book card → Book detail page (modal overlay)
   ↓
BOOK DETAIL MODAL (Implied overlay)
   └─ Cover image
   └─ Title, author, narrator, rating
   └─ "Listen to Free Sample" → Inline player plays sample
   └─ "Read Synopsis" → Expand description
   └─ "Add to Wishlist" (heart icon)
   └─ "See Similar Books" → Related titles
   └─ "Read Reviews" → Jump to Page 29 (Reviews)
   └─ "Purchase / Add Credit" → PAGE 31 or PAGE 35
   ↓
[Option D: Search flow]
   ↓
PAGE 20: Search / Explore
   └─ Type book title / author name → Auto-suggestions appear
   └─ Tap suggestion → Book detail
   └─ OR hit search → PAGE 22 (Results)
   ↓
PAGE 22: Search Results
   └─ Grid of books matching query
   └─ Sort: Relevance, Newest, Highest Rated, Most Popular
   └─ Filters: Genre, Duration, Language, Narrator
   └─ Tap book → Book detail
   └─ "View Author" link → PAGE 23 (Author Profile)
   ↓
PAGE 23: Author / Narrator Detail
   └─ Author bio + photo
   └─ "Follow" button → Saves author, enables notifications
   └─ "Books by [Author]" list → Grid of all books
   └─ Tap book → Book detail
   ↓
[At any book detail, user decides to purchase]
   ↓
PAGE 31: Pricing / Subscription Plans (if user not subscribed)
   └─ Show all available plans
   └─ User selects plan → PAGE 35 (Free Trial Confirmation)
   └─ OR "Already have a subscription?" → PAGE 36 (Manage Subscription)
   ↓
PAGE 35: Free Trial Confirmation
   └─ Confirm plan selection
   └─ "Start Free Trial" → Payment processing
   └─ Auto-redirect to PAGE 5 (Home) after success
   └─ Notification: "7-day free trial started!"
   ↓
[If user already subscribed, purchase is instant]
   ↓
BOOK NOW IN LIBRARY
   └─ Success notification: "Added to your library!"
   └─ Option: "Listen Now" → PAGE 10 (Player)
   └─ OR "View in Library" → PAGE 14
   ↓
PAGE 14: My Library
   └─ New book appears in "Continue Reading" or "All" tab
   └─ Book highlighted with "New" badge
   ↓
END: Book added to collection, ready to listen
```

---

### FLOW 3: Listening & Bookmarking (Power User)

```
START: User opens book that's in-progress
   ↓
PAGE 14: My Library
   └─ Tap on book with progress ring (e.g., "40% complete")
   ↓
BOOK DETAIL MODAL
   └─ "Resume at [timestamp]" button → PAGE 10
   ↓
PAGE 10: Full Player
   └─ Book resumes at saved position
   └─ User listens for 20 minutes
   └─ Reaches important quote, taps "Bookmark" button
   └─ Small menu appears:
      ├─ "Add Note" → Text input appears
      ├─ "Highlight This" → Color palette (yellow/blue/green)
      ├─ "Save Clip" (custom length) → Inputs duration
      └─ "Bookmark" → Saved instantly
   ↓
PAGE 13: Bookmarks & Notes Panel (overlay opens)
   └─ Shows all bookmarks for current book
   └─ New bookmark appears at top with:
      ├─ Timestamp
      ├─ Note text preview
      ├─ "Play Clip" button
      ├─ "Edit" / "Delete" buttons
      └─ "Share" button
   ↓
LATER: User wants to review bookmarks
   ↓
PAGE 14: My Library
   └─ Tap book → Book detail
   └─ "View Bookmarks" button → PAGE 51
   ↓
PAGE 51: Saved Bookmarks & Passages
   └─ "Bookmarks" tab (default)
   └─ All bookmarks from all books
   └─ Sorted by: Book, Timestamp, Date Created
   └─ Filter by book → Shows only bookmarks from that book
   └─ Tap bookmark → "Jump to" option
      └─ Opens PAGE 10 (Player) at that timestamp
   ↓
EXPORT WORKFLOW (Advanced)
   └─ PAGE 13: "Export Bookmarks & Notes" button
   └─ Choose format: PDF, Text, Email
   └─ Email sends PDF attachment with all notes/bookmarks
   ↓
END: User has portable study notes from audiobook
```

---

### FLOW 4: Family Sharing & Kids Mode

```
START: Parent user wants to set up family account
   ↓
PAGE 48: User Profile / Account Home
   └─ Tap "Family & Kids" section
   ↓
PAGE 44: Family Account / Family Sharing Setup
   └─ Current family members list (initially empty)
   └─ "Add Family Member" button
   ├─ Input child's name
   ├─ Select age group (3-5, 6-8, 9-11, 12-14, 15-17)
   ├─ Input email/phone
   └─ "Send Invitation" → Invite sent
   ↓
CHILD JOINS (via email invite link)
   └─ Creates child account
   └─ Linked to parent's family group
   ↓
PARENT ENABLES KIDS MODE
   ↓
PAGE 45: Kids Mode / Parental Controls
   └─ "Kids Mode" toggle → ON
   └─ Prompted to set 4-digit PIN
   └─ Select age-appropriate rating (ages 6-8, 9-11, etc.)
   └─ Set daily listening limit (e.g., 1 hour)
   └─ Set allowed listening hours (e.g., 3 PM - 8 PM)
   └─ Content restrictions: Block explicit, block shopping, etc.
   └─ Save settings
   ↓
CHILD'S EXPERIENCE (Kids Mode Active)
   ↓
PAGE 1: App Launch (Child logs in or parent unlocks)
   ↓
PAGE 5: Home / Dashboard (Kids Version)
   └─ Filtered interface (no adult content)
   └─ Only age-appropriate recommendations
   └─ Simplified controls (no settings access)
   ↓
CHILD BROWSES KIDS LIBRARY
   ↓
PAGE 46: Kids Content Library / Curated Kids Browse
   └─ Age filter: "Ages 6-8" (as set by parent)
   └─ Collections:
      ├─ "Best for This Age"
      ├─ "Award-Winning Kids Books"
      ├─ "Fairy Tales & Classics"
      ├─ "Educational Audiobooks"
      └─ "Funny & Silly"
   └─ Tap book → Book detail (kid-safe version)
   └─ "Listen" → PAGE 10 (Simplified player, no ads)
   ↓
PARENT MONITORS ACTIVITY
   ↓
PAGE 47: Child Profile / Activity Dashboard
   └─ Listening time today
   └─ Books listened to today
   └─ Current streak
   └─ Progress toward listening goal (set by parent)
   ↓
LISTENING TIME LIMIT REACHED
   └─ Player pauses automatically
   └─ Message: "Listening time limit reached. Ask parent to extend."
   └─ Parent can extend by entering PIN on PAGE 45
   ↓
END: Safe, controlled listening experience for children
```

---

### FLOW 5: Social Reading & Book Clubs

```
START: User discovers book club feature
   ↓
PAGE 24: Social / Community Hub
   └─ "For You" feed (posts from friends, clubs)
   └─ "Book Clubs" tab → PAGE 25
   ↓
PAGE 25: Book Clubs
   └─ Browse active book clubs
   └─ Filter: All, Joined, My Clubs, Recommended
   └─ See club cards:
      ├─ Club name
      ├─ Current book being discussed
      ├─ Member count
      ├─ Next discussion date
      └─ "Join" or "View" button
   ↓
USER JOINS BOOK CLUB
   └─ Taps "Join Club" → Instant member
   ↓
PAGE 25: Book Club Detail (expanded view)
   └─ Club name + description
   └─ "Members" section (avatars + names)
   └─ "Current Book" → Book cover + synopsis
   └─ "Discussion Chat" section:
      ├─ Messages from members
      ├─ Timestamp for each
      ├─ Reactions (emojis)
      └─ "Post Message" input
   └─ "Schedule" section:
      ├─ Next discussion: [Date/Time]
      ├─ "Join Live Discussion" button (if happening now)
      └─ Past discussions archive
   ↓
USER PARTICIPATES IN CHAT
   └─ Types message: "Just finished chapter 5!"
   └─ Posts message → Appears in chat
   └─ Other members like/react
   └─ Discussion thread grows
   ↓
LIVE DISCUSSION EVENT STARTS
   ↓
PAGE 26: Live Discussion / Story Circle
   └─ Live indicator (red "LIVE" badge)
   └─ Host: [Author Name] or [Club Moderator]
   └─ Top 50%: Host video/audio feed
   └─ Bottom 50%: Live chat from participants
   └─ "Ask a Question" input → Submitted to host
   └─ Reactions: Heart, fire, thumbs up emojis
   └─ Poll widget (if host creates poll)
   └─ "Raise Hand" button to speak
   ↓
AFTER DISCUSSION ENDS
   └─ Saved as recording
   └─ Accessible in "Past Discussions" archive
   └─ Members can rewatch/relisten
   ↓
USER CREATES OWN BOOK CLUB
   ↓
PAGE 25: "Create Club" floating button
   └─ Input club name
   └─ Select current book (from library)
   └─ Set description
   └─ Set discussion schedule
   └─ "Create" → Club created
   └─ Invite members (share link or select friends)
   ↓
END: Social reading experience with community
```

---

### FLOW 6: Gamification & Reading Challenges

```
START: User browses social feed
   ↓
PAGE 24: Social / Community Hub
   └─ Sees "Reading Challenge" post
   └─ "2025 Reading Challenge: Read 50 Books" banner
   └─ "Join Challenge" button → PAGE 28
   ↓
PAGE 28: Reading Challenge / Community Challenge Page
   └─ Challenge details: "Read 50 books in 2025"
   └─ Your progress: "0 of 50 books" (progress bar)
   └─ Leaderboard: Top 10 users
   └─ "Join Challenge" button (if not joined)
   ↓
USER JOINS CHALLENGE
   └─ Confirmation: "You've joined! Start reading to climb the leaderboard."
   ↓
LISTENING DRIVES PROGRESS
   └─ Every book finished → Progress increments
   └─ Notification: "You finished 1 book! +1 point. You're 523rd on leaderboard."
   ↓
GAMIFICATION ENGAGEMENT
   └─ Milestone rewards:
      ├─ 5 books: "🏅 Bronze Reader" badge
      ├─ 10 books: "🥈 Silver Bookworm" badge
      ├─ 25 books: "🥇 Gold Listener" badge
      ├─ 50 books: "👑 Challenge Master" badge
      └─ Unlock rewards: Credits, premium features, exclusive content
   ↓
STREAKS & DAILY ENGAGEMENT
   ↓
PAGE 5: Home / Dashboard
   └─ "Listening Streaks" card shows:
      ├─ "5-day streak! 🔥"
      ├─ "Listen today to continue your streak"
      └─ Goal: "Reach 30-day streak for +10 coins"
   ↓
DAILY LOGIN BONUS
   └─ APP 1: Opens app → Notification: "Daily bonus: +5 coins! Streak: 5 days"
   └─ PAGE 5: Home shows streak counter
   └─ Tap streak card → PAGE 48 (Stats dashboard)
   ↓
PAGE 48: User Profile / Stats
   └─ Shows annual stats:
      ├─ "Books Read This Year: 23"
      ├─ "Total Listening Hours: 156 hours"
      ├─ "Current Streak: 5 days"
      ├─ "Coins Earned: 125"
      └─ Monthly listening bar chart
   ↓
LEADERBOARD COMPETITION
   └─ USER climbs leaderboard
   └─ Notification: "You passed [Friend Name]! You're now 125th on leaderboard."
   └─ Invite friends to challenge
   └─ PAGE 28: Share challenge link
   ↓
END OF YEAR
   └─ "2024 Listening Wrap-Up"
   └─ Summary: "You read 47 books, 312 hours!"
   └─ "Your favorite genre: Science Fiction"
   └─ Share wrap-up to social media
   ↓
END: User maintains engagement through gamification
```

---

### FLOW 7: Monetization & Subscription Upgrade

```
START: Free user wants premium features
   ↓
PAGE 5: Home / Dashboard
   └─ Banner: "Upgrade to Premium for unlimited listening!"
   └─ "View Plans" button → PAGE 31
   ↓
PAGE 31: Pricing / Subscription Plans
   └─ Five plan cards displayed:
      ├─ Free with Ads ($0)
      ├─ Credits ($14.99/mo) ← Marked "Popular"
      ├─ Unlimited Streaming ($12.99/mo)
      ├─ Hourly Plan ($9.99/mo for 20 hours)
      └─ Family Plan ($19.99/mo)
   └─ User reads details
   └─ Taps "Start 30-Day Free Trial" on Credits plan
   ↓
PAGE 35: Free Trial Confirmation
   └─ Confirms: "Free for 30 days, then $14.99/month"
   └─ Auto-renewal toggle (ON by default)
   └─ Accepts terms
   └─ "Start Free Trial" button
   ↓
PAYMENT PROCESSING
   └─ Redirects to PAGE 32 (Payment Method)
   └─ "Add Payment Method" if first time
   └─ Select payment: Credit Card, Apple Pay, Google Pay, PayPal
   └─ Enters payment details
   └─ Confirms → Payment processed
   ↓
SUCCESS
   └─ Confirmation: "Your free trial has started!"
   └─ Auto-redirect to PAGE 5 (Home)
   └─ Notification: "Welcome to Premium! You have 30 days before first charge."
   ↓
DURING FREE TRIAL
   └─ User enjoys unlimited listening
   └─ PAGE 5 shows: "Premium Member - Trial ends in 25 days"
   └─ PAGE 36: "Manage Subscription" available
   ↓
UPGRADE FLOW (if user on different plan)
   ↓
PAGE 48: User Profile
   └─ "Manage Subscription" section → PAGE 36
   ↓
PAGE 36: Manage Subscription
   └─ Current plan: "Hourly Plan (20 hours/month)"
   └─ Next billing date: January 15, 2026
   └─ Amount: $9.99/month
   └─ "Change Plan" button → PAGE 31
   ↓
PAGE 31: Plan selection (user already premium)
   └─ Shows "Current Plan" badge on Hourly Plan
   └─ Selects "Unlimited Streaming ($12.99/mo)"
   └─ "Switch to This Plan" button
   ↓
CONFIRMATION
   └─ "Switch from Hourly to Unlimited?"
   └─ "Credit $0.00 applied to next charge"
   └─ Confirm → Plan changed immediately
   └─ Notification: "Switched to Unlimited! No credits needed anymore."
   ↓
DOWNGRADE / CANCEL FLOW
   ↓
PAGE 36: Manage Subscription
   └─ "Pause Subscription" or "Cancel Subscription" button (red)
   ↓
CANCEL FLOW
   └─ Modal: "Are you sure you want to cancel?"
   └─ Offers: "Switch to Unlimited instead?" with price comparison
   └─ Survey: "What could we have done better?"
   └─ "Confirm Cancellation" button
   └─ Confirmation: "Your subscription will end on [Date]"
   └─ Can still listen until end date
   ↓
END: User has chosen plan, can manage/cancel anytime
```

---

### FLOW 8: Price Comparison & Smart Alerts

```
START: User wants to add book to wishlist with price tracking
   ↓
BOOK DETAIL (Implied)
   └─ "Add to Wishlist" heart icon
   └─ Book added to wishlist
   ↓
PAGE 17: Wishlist / Want to Read
   └─ Book appears in list
   └─ Shows current price: "$14.99"
   └─ "Price Alert" toggle (if feature enabled)
   └─ User enables toggle
   └─ Modal: "Notify me when price drops below: [$____]"
   └─ User inputs: "$5.99"
   └─ "Set Alert" → Saved
   ↓
LATER: Book goes on sale
   └─ Price drops to $4.99 on Audible
   └─ System detects price change
   └─ Notification: "Price Alert! '[Book Name]' is now $4.99 (was $14.99)"
   └─ Tap notification → PAGE 17 (Wishlist)
   └─ "Buy Now" button (if integrated shopping)
   ↓
[Alternative: Cross-platform price comparison]
   ↓
BOOK DETAIL
   └─ User wants to compare prices across platforms
   └─ "Price Comparison" button (if feature enabled)
   ↓
PRICE COMPARISON MODAL (Implied)
   └─ Shows prices across platforms:
      ├─ Audible: $14.99 (credit required)
      ├─ Apple Books: $9.99 (one-time purchase)
      ├─ Google Play: $8.99 (one-time purchase)
      ├─ Kobo: $7.99 (one-time purchase)
      └─ Libby (Library): FREE (requires library card)
   └─ "View on Libby" button → Opens library lending
   └─ "Buy on Kobo" button → Affiliate link
   └─ Each button includes commission for app
   ↓
USER SELECTS CHEAPEST OPTION
   └─ Taps "Buy on Kobo ($7.99)"
   └─ Opens Kobo website (external) via affiliate link
   └─ App earns 5-15% commission
   ↓
END: User finds best deal, app earns revenue
```

---

### FLOW 9: AI Narration & Voice Selection

```
START: User opens book with multiple narration options
   ↓
BOOK DETAIL MODAL
   └─ Shows narrator options:
      ├─ Primary narrator: "Stephen Fry (Human)" ← $14.99
      ├─ Alternative: "AI Voice - Clara (Synthetic)" ← $9.99 (30% discount)
      └─ Alternative: "AI Voice - Marcus (Synthetic)" ← $9.99
   └─ User curious about AI quality
   └─ Taps "Listen to Sample" on AI narrator
   ↓
SAMPLE PLAYER
   └─ Plays 60-90 second sample with AI narration
   └─ User compares to human narrator sample
   └─ Decides AI is acceptable & cheaper
   └─ "Buy AI Version ($9.99)" button
   ↓
PAYMENT
   └─ If on Credits plan: Deducts 1 credit (or prorated cost)
   └─ If on Unlimited: Adds to library instantly
   └─ If Hourly: Deducts from monthly hours
   ↓
PAGE 10: Full Player
   └─ User opens AI-narrated book
   └─ "Narrator" label shows: "Narrated by: Clara (AI)"
   └─ All playback features available
   └─ User can switch to human version later (if purchased both)
   ↓
NARRATOR SELECTION MODAL (Page 7)
   └─ Available for books with multiple narrators
   └─ Shows all options with samples
   └─ Tap to switch narrators
   ↓
END: User gets cheaper book with AI narration
```

---

### FLOW 10: Interactive Audiobooks & Branching Stories

```
START: User browses premium interactive story
   ↓
PAGE 6: Discover / Browse
   └─ "Interactive Audiobooks" collection highlighted
   └─ "The Murder Mystery" card with "Interactive" badge
   └─ "Try Free" button
   ↓
PAGE 10: Full Player (Interactive Mode)
   └─ Narration plays: "You arrive at the mansion..."
   └─ At decision point, narration pauses
   └─ Choice popup appears:
      ├─ "🔍 Search for clues"
      ├─ "🚪 Knock on the door"
      └─ "🏃 Run away"
   └─ User taps "Search for clues"
   └─ Audio resumes on new branch
   ↓
BRANCHING PATH A
   └─ Narration: "You find a hidden letter..."
   └─ Continues for 10 minutes
   └─ Next choice: Fight or flee?
   └─ Tap "Fight" → Different story path
   ↓
ENDING A
   └─ User defeats villain
   └─ Achievement: "✅ Hero Ending"
   └─ Suggestions: "Try Flee path for alternate ending"
   └─ "Replay" button → Restart story
   └─ "See All Endings" link → Shows all 5 possible endings
   ↓
REPLAY FEATURE
   └─ User restarts story (counts as new listen)
   └─ Makes different choice: "Flee"
   ↓
ENDING B (Different)
   └─ User escapes but villain escapes too
   └─ Achievement: "✅ Escape Ending"
   └─ Progress: "2 of 5 endings unlocked"
   ↓
MONETIZATION
   └─ First playthrough: Free (unlock 1 ending)
   └─ Additional playthroughs: $2.99/replay (unlock alternate endings)
   └─ OR: Unlimited for Premium subscribers
   └─ OR: Use coins (Pocket FM model): 50 coins per new ending
   ↓
END: User explores multiple story branches
```

---

### FLOW 11: Language Learning Integration

```
START: User wants to learn Spanish
   ↓
PAGE 43: Language & Region Settings
   └─ "Content Language" section
   └─ Multi-select: English (primary), Spanish (learning)
   └─ "Narration Accent" dropdown: "Spanish (Spain)"
   └─ "Romanization" for applicable scripts
   └─ Save settings
   ↓
PAGE 6: Discover / Browse
   └─ "Learning" collection appears
   └─ "Spanish Audiobooks for Learners" section
   └─ Books in Spanish with English support
   ↓
BOOK DETAIL
   └─ Language options:
      ├─ "Spanish (Spain) narration"
      ├─ "Spanish (Mexico) narration"
      └─ "English narration" (for reference)
   └─ User selects "Spanish (Spain)"
   ↓
PAGE 10: Full Player (Learning Mode)
   └─ "Transcript" tab available
   └─ Shows dual-language display:
      ├─ Spanish text (highlighted word-by-word)
      ├─ English translation below
   └─ Playback controls:
      ├─ Speed: Slow (0.75x), Normal (1.0x), Fast (1.5x)
      └─ Pronunciation: Tap any word → Audio example plays
   └─ "Dictionary" feature: Tap Spanish word → Definition + pronunciation
   ↓
LISTENING WITH TRANSCRIPT
   └─ User listens to sentence in Spanish
   └─ Text highlights in sync (karaoke style)
   └─ Taps unknown word → Definition popup
   └─ Continues listening with reinforcement
   ↓
GAMIFICATION FOR LEARNERS
   └─ "Spanish Learning Streak" → Points for daily listening
   └─ "Vocabulary" badge → Unlocked after learning X words
   └─ Recommendations: "Try this similar book to reinforce vocabulary"
   ↓
END: User learns language while enjoying audiobooks
```

---

### FLOW 12: Settings & Accessibility Customization

```
START: Visually impaired user opens app
   ↓
PAGE 4: Preferences / Account Setup (Onboarding)
   └─ "Accessibility Preference" section
   └─ Toggle: "Enable High Contrast Mode"
   └─ Toggle: "Enable Dyslexia Font"
   └─ Toggle: "Enable Screen Reader Optimization"
   └─ User enables all three
   └─ "Continue to Home" → PAGE 5
   ↓
PAGE 5: Home (Accessibility Mode)
   └─ High contrast: White text on black background
   └─ Button sizes: Extra large for touch accuracy
   └─ Text: OpenDyslexic font applied
   └─ Screen reader active: All elements announced
   ↓
PAGE 38: Accessibility Settings (Detailed)
   └─ "Visual Settings" section:
      ├─ Dyslexia Font: Toggle + sample text
      ├─ High Contrast: Toggle + preview
      ├─ Text Size: Slider (small → large)
      ├─ Color Blind Filters: Dropdown (Protanopia, Deuteranopia, etc.)
      └─ Reduce Motion: Toggle
   ↓
   └─ "Audio Settings" section:
      ├─ Screen Reader Optimization: Toggle
      ├─ Closed Captions: Toggle
      ├─ Audio Description: Toggle
      ├─ Keyboard Navigation: Toggle
      └─ Transcript Text Size: Slider
   ↓
USER CUSTOMIZES
   └─ Sets Text Size to Large
   └─ Selects "Protanopia" color filter (colorblind friendly)
   └─ Enables "Reduce Motion" (fewer animations)
   └─ Save settings
   ↓
ENTIRE APP UPDATED
   └─ All text enlarged
   └─ Colors adjusted for colorblind visibility
   └─ Animations disabled
   └─ Changes persist across all pages
   ↓
KEYBOARD NAVIGATION
   └─ User plugs in Bluetooth keyboard
   └─ Tab key moves focus between buttons
   └─ Enter/Space activates buttons
   └─ Arrow keys navigate lists
   └─ Shortcuts: Cmd+P (Play/Pause), Cmd+S (Search), etc.
   ↓
PAGE 10: Full Player (Accessible Mode)
   └─ All controls keyboard accessible
   └─ Screen reader announces: "Play button. Playback paused. Chapter 5 of 24."
   └─ User presses Space to play
   └─ Audio plays, screen reader silent during narration
   ↓
TRANSCRIPT WITH CAPTIONS
   └─ Closed Captions enabled → Full transcript synced to audio
   └─ Word-by-word highlighting
   └─ Descriptions of sound effects: "[door slams loudly]", "[music plays]"
   ↓
END: Fully accessible experience for user with disabilities
```

---

### FLOW 13: Payment & Billing Management

```
START: User wants to add/change payment method
   ↓
PAGE 48: User Profile / Account Home
   └─ "My Account" section → PAGE 32 (Payment Methods)
   ↓
PAGE 32: Payment Method / Billing Details
   └─ Current method: "Visa ending in 4242" + expiry date
   └─ "Edit" button (change or remove)
   └─ "Add Payment Method" button (backup)
   └─ Tap "Add"
   ↓
PAYMENT METHOD MODAL
   └─ Options:
      ├─ Credit/Debit Card
      ├─ Apple Pay
      ├─ Google Pay
      ├─ PayPal
      └─ (Region-specific: Bank transfer, UPI for India)
   ↓
USER SELECTS APPLE PAY
   └─ Redirected to Apple Pay flow
   └─ Authenticates with Face ID
   └─ Returns to PAGE 32
   └─ Notification: "Apple Pay added successfully"
   ↓
BILLING HISTORY
   └─ Tap "View Billing History" → PAGE 33
   ↓
PAGE 33: Billing History / Invoice
   └─ List of all charges (newest first):
      ├─ Jan 15, 2026: Premium Plan - $14.99 (Paid)
      ├─ Dec 15, 2025: Premium Plan - $14.99 (Paid)
      ├─ Nov 15, 2025: Premium Plan - $14.99 (Paid)
      └─ [More charges...]
   └─ Each charge shows:
      ├─ Date
      ├─ Plan name
      ├─ Amount
      ├─ Status (Paid, Pending, Failed)
      ├─ "Download Invoice" button (PDF)
      └─ "View Details" button
   ↓
MANAGE SUBSCRIPTION
   └─ Renewal date: February 15, 2026
   └─ Auto-renewal: ON
   └─ Next charge: $14.99
   └─ Toggle "Auto-renewal" to OFF → Subscription ends on next date
   ↓
FAILED PAYMENT RECOVERY
   └─ Notification: "Payment failed on Jan 15"
   └─ PAGE 32: "Update payment method to restore access"
   └─ User adds new card
   └─ System retries charge
   └─ Notification: "Payment successful! Your premium access is restored."
   ↓
END: User manages billing seamlessly
```

---

### FLOW 14: Wishlist & Smart Recommendations

```
START: User builds wishlist
   ↓
PAGE 6: Discover / Browse
   └─ Sees interesting book: "The Midnight Library"
   └─ Taps heart icon "Add to Wishlist"
   └─ Book added instantly
   └─ Toast: "Added to Wishlist"
   ↓
PAGE 17: Wishlist / Want to Read
   └─ "The Midnight Library" appears in wishlist
   └─ Shows price, availability, release date
   └─ User continues adding books (5 more added)
   ↓
SMART RECOMMENDATIONS ENGINE
   └─ System analyzes wishlist:
      ├─ Fiction genre: 60%
      ├─ Fantasy sub-genre: 40%
      ├─ Average rating: 4.5/5
      ├─ Popular narrators: "Kate Mara", "Stephen Fry"
      └─ Similar authors: "Nicholas Sparks", "Rebecca Ross"
   ↓
PAGE 5: Home / Dashboard
   └─ "Recommended based on your wishlist" section appears
   └─ Shows similar books to wishlist items
   └─ "If you liked [Wishlist Book], you'll love..."
   └─ Book cards: "The Invisible Life of Addie LaRue"
   ↓
USER BROWSES RECOMMENDATIONS
   └─ Taps recommended book
   └─ BOOK DETAIL: Shows why recommended
   └─ "Based on 3 books in your wishlist"
   └─ Option: "Add to Wishlist" (if not already)
   └─ Option: "Add to Cart / Purchase"
   ↓
PRICE ALERT (On wishlist)
   └─ User sets price alert on wishlist item
   └─ PAGE 17: Toggle "Price Alerts" ON
   └─ User sets threshold: "Notify when under $8"
   ↓
LATER: Book goes on sale
   └─ Notification: "Price Alert! '[Book]' is now $6.99 (was $14.99)"
   └─ Tap → PAGE 17 (Wishlist highlighted)
   └─ "Buy Now" button available
   └─ Checkout → Book added to library
   ↓
READING PROGRESS INSIGHTS
   └─ PAGE 18: Reading Log shows patterns
   └─ "Your favorite genres: Fiction (40%), Mystery (30%)"
   └─ Recommendations refined based on completion rates
   └─ User finishes books faster in certain genres → More of those recommended
   ↓
END: Wishlist drives personalized recommendations & monetization
```

---

### FLOW 15: Audio Clip Sharing & Social Virality

```
START: User finds powerful quote during listening
   ↓
PAGE 10: Full Player
   └─ Listening to: "The Six of Crows"
   └─ Hears powerful dialogue
   └─ Taps "Share" button
   ↓
PAGE 27: Share Audio Clip Modal
   └─ Clip displayed:
      ├─ Book cover thumbnail
      ├─ Title + Author
      ├─ Duration: "00:15 - 00:45 of Chapter 3"
      ├─ Player to preview clip
      └─ "That's my favorite part too!" reaction option
   ↓
CUSTOMIZE CLIP BEFORE SHARING
   └─ Add caption: "This line hit different 😭"
   └─ Add sticker/emoji overlay: "❤️"
   └─ Choose playback speed: "Include at 1.0x speed"
   ├─ Share to: Instagram Stories
   ├─ Share to: Instagram Feed
   ├─ Share to: TikTok
   ├─ Share to: Twitter/X
   ├─ Share to: WhatsApp
   └─ Share to: Email
   ↓
USER SHARES TO INSTAGRAM STORIES
   └─ Redirected to Instagram app
   └─ Pre-populated with:
      ├─ 30-second audio clip (playable)
      ├─ Book cover as sticker
      ├─ User's caption
      ├─ App logo watermark
      └─ "Tap to listen on [App Name]" link
   └─ User customizes in Instagram (adds more stickers)
   └─ Posts to Story
   ↓
VIRALITY & CLICK-THROUGH
   └─ Friend watches Story
   └─ Taps clip → Redirected to [App Name]
   └─ Deep link → Opens book detail for "The Six of Crows"
   └─ "Try Sample" or "Add to Wishlist" button
   └─ If clicks "Try Sample" → PAGE 8 (Sample plays)
   └─ If clicks "Listen" → PAGE 10 (Player opens, books purchased with credits)
   ↓
TRACKING & ANALYTICS
   └─ App tracks: Shares → Click-through → Conversions
   └─ Shows in PAGE 37 (Referral Program) as user acquired
   └─ Awards referral points if friend signs up/subscribes
   ↓
END: Viral loop: Sharing → Discovery → Conversions → Growth
```

---

### FLOW 16: Content Rating & Age-Gated Purchases

```
START: User searches for mature content
   ↓
PAGE 20: Search / Explore
   └─ Types: "Explicit fiction"
   └─ Results filtered by user's region settings
   ↓
PAGE 22: Search Results
   └─ Shows books with age ratings visible
   └─ "Mature 18+" label on explicit titles
   └─ Standard "All Ages" label on general titles
   ↓
USER UNDER 18 CLICKS MATURE BOOK
   └─ Book detail shows warning:
      ├─ Age rating: 18+
      ├─ Content warnings: Violence, sexual content, language
      ├─ Parental control: Might be restricted for your account
      └─ "Continue (Requires Parent Approval)" button
   ↓
PARENTAL APPROVAL FLOW
   └─ Parent's email notified: "[Child Name] requested 18+ book approval"
   └─ Parent can:
      ├─ Approve: "Yes, allow this book"
      ├─ Deny: "No, not appropriate"
      └─ Allow all 18+ books: "Always allow mature content"
   ↓
PARENT APPROVES
   └─ Child notification: "Parent approved! You can now listen."
   └─ Child adds to library → PAGE 10 (Listen)
   ↓
USER 18+ CLICKS MATURE BOOK
   └─ Book detail shows age rating
   └─ "18+" label
   └─ "Add to Library" or "Buy" button (no approval needed)
   └─ Instant access
   ↓
CONTENT FILTERING (Kids Mode)
   └─ PAGE 45: Kids Mode enabled
   └─ "Age 9-11" selected
   └─ All 18+ books hidden from library/recommendations
   └─ If child tries to access via URL: "This content is not available in Kids Mode"
   └─ Parents can adjust age filter to allow certain content
   ↓
END: Age-appropriate content access & parental oversight
```

---

### FLOW 17: Referral Program & Incentives

```
START: User wants to earn free months
   ↓
PAGE 37: Referral Rewards Program
   └─ Your referral link: [Unique Link]
   └─ Copy button → Copies to clipboard
   └─ Share options:
      ├─ Email
      ├─ Instagram
      ├─ Twitter
      ├─ WhatsApp
      └─ Generate QR code
   ↓
PROGRAM DETAILS
   └─ How it works: "Share your link → Friend signs up → You earn 1 month free"
   └─ Reward: 1 free month for every 2 friends who sign up & subscribe
   └─ Friend gets: "$9.99 for first month (50% off)"
   ↓
USER SHARES LINK
   └─ Email invite: "Hey! I love [App Name]. Use my link to get 50% off first month: [Link]"
   └─ Friend clicks link
   └─ Friend taken to PAGE 4 (Sign Up with referral code pre-filled)
   ↓
FRIEND SIGNS UP
   └─ Name, email, password
   └─ Referral code visible: "REFERRAL_CODE: XYZ123"
   └─ Continues to PAGE 31 (Pricing)
   └─ Sees: "First month 50% OFF thanks to referral!"
   └─ Selects plan, enters payment
   └─ Subscription activated
   ↓
REFERRER NOTIFIED
   └─ Notification: "[Friend Name] signed up using your referral!"
   └─ Referral status: "1 of 2 friends needed for free month"
   └─ Referral history page shows:
      ├─ Friend name
      ├─ Date referred
      ├─ Status: "Subscribed ✓"
      ├─ Your reward: "+1 month credit"
      └─ Expires: [Date]
   ↓
SECOND FRIEND SIGNS UP
   └─ Notification: "[Second Friend] signed up!"
   └─ Referral status: "2 of 2 - Reward unlocked!"
   └─ Notification: "You earned 1 month free! Applied to your account."
   └─ PAGE 36: Shows "Credits: +1 month added"
   └─ Next billing date extended automatically
   ↓
ONGOING VIRALITY
   └─ User keeps sharing (has high stake: earn credits)
   └─ Monthly: 5 friends = 2.5 months free
   └─ Becomes powerful retention driver
   └─ Top referrers: Leaderboard on PAGE 37
   ↓
END: Viral growth loop through incentives
```

---

### FLOW 18: Error Handling & Network Recovery

```
START: User listening, connection drops
   ↓
PAGE 10: Full Player
   └─ Playing audiobook on cellular connection
   └─ Network drops (WiFi disabled, no signal)
   ↓
IMMEDIATE RESPONSE
   └─ Audio playback continues (if pre-buffered)
   └─ Attempts to resume streaming
   └─ After 5 seconds with no connection:
      ├─ Top banner appears (yellow): "Connection lost. Retrying..."
      ├─ Player continues with buffered audio
      └─ Automatic retry every 5 seconds
   ↓
10 SECONDS STILL NO CONNECTION
   └─ Banner changes to red: "No connection. Playing offline."
   └─ If offline download available: Switches to local file
   └─ If no offline file: Playback pauses
   └─ Player shows: "Connection Lost" message
   └─ "Retry" button available
   └─ "Download for Offline" button appears
   ↓
USER EXITS PLAYER
   └─ Closes player during connection loss
   └─ App stores exact timestamp
   └─ Notification: "Connection lost, but your place is saved"
   ↓
CONNECTION RESTORED
   └─ Network reconnects (user moves to WiFi area)
   └─ Notification: "Connection restored"
   └─ Player auto-resumes if app still open
   └─ Syncs timestamp to cloud
   ↓
PAYMENT FAILURE
   ↓
SCENARIO: Auto-renewal fails
   └─ Subscription due: January 15, 2026
   └─ Payment declined (expired card)
   └─ System retry #1: Waits 3 days, retries
   └─ Still fails → User notified: "Payment failed"
   └─ Notification: "Your subscription couldn't renew. Update payment method to continue."
   └─ Link to PAGE 32 (Payment Methods)
   ↓
USER UPDATES PAYMENT
   └─ PAGE 32: Adds new payment method
   └─ System retries charge
   └─ Success: "Payment successful! Premium restored."
   └─ Continued access to premium features
   ↓
USER IGNORES NOTIFICATION
   └─ Premium access suspended after 10 days
   └─ PAGE 5: Home shows: "Your subscription expired. Renew to continue."
   └─ Try to play premium book → Paywall: "Upgrade to Premium"
   └─ "Renew Now" button → PAGE 31
   └─ OR "View on Free Tier" option (limited library)
   ↓
BUG / CRASH FLOW
   ↓
PAGE 10: Player crashes while listening
   └─ App force closes
   └─ User frustrated, reopens app
   ↓
PAGE 1: Splash screen (app restart)
   └─ Auto-redirect to PAGE 5 (Home)
   └─ PAGE 11: Mini-player shows at bottom with last book
   └─ Player still has saved position
   └─ Resume button: "Resume at 2:34:15"
   └─ User taps → PAGE 10 opens at exact position
   └─ Playback continues as if no crash
   ↓
ERROR MODAL
   └─ If app detects crash: "We're sorry, the app crashed"
   └─ Options:
      ├─ "Send Crash Report" → Auto-sends to support
      ├─ "Contact Support" → Opens support page
      └─ "Continue" → Dismisses modal
   ↓
END: Graceful error handling maintains user trust
```

---

## SECTION 3: PAGE ADJACENCY MATRIX (Navigation Connections)

### Quick Reference: Which Pages Connect to Which

| From Page | Can Navigate To | Via | Notes |
|-----------|-----------------|-----|-------|
| **1: Splash** | 2, 5 | Auto-redirect | 1→2 (new user), 1→5 (existing) |
| **2: Welcome** | 3 | "Continue" button | Only forward |
| **3: Sign Up/Login** | 4 | "Sign Up" / "Already have account?" | Conditional |
| **4: Preferences** | 5 | "Continue to Home" | Only forward |
| **5: Home** | 6,8,9,10,11,14,17,20,23,24,25,27,31,48 | Bottom nav + carousel taps | Hub page |
| **6: Discover** | 5,20,23,28,31 | Top back button, bottom nav | Secondary discovery |
| **7: Mood Search** | 22 | Select mood → filtered results | Specialized search |
| **8: Samples** | 10,31 | "Listen Sample" or "Buy Book" | Discovery + monetization |
| **9: Countdown** | 10,31 | "Notify Me" or "Pre-order" | Speculative content |
| **10: Full Player** | 11,13,14,27,48 | Minimize, bookmarks, share, stats | Core experience |
| **11: Mini Player** | 10 | Swipe up | Minimized state |
| **12: Car Mode** | 10 | Toggle in player | Alternate layout |
| **13: Bookmarks** | 10,51 | Open/close panel | Overlay modal |
| **14: My Library** | 5,6,10,17,18,19,50,51 | Bottom nav, book taps, filters | Content hub |
| **15: Filters** | 14,22 | Filter button, apply | Modal overlay |
| **16: Shelves** | 14 | Manage shelves button | Modal overlay |
| **17: Wishlist** | 5,14,22,31 | Bottom nav, "Add to Wishlist", search results | Aspirational list |
| **18: Reading Log** | 14,28,48 | "Stats" button, referral to challenges | Analytics view |
| **19: Series** | 14,23 | Series grouping, author page | Sub-collection |
| **20: Search** | 15,22,23 | Type query, filters, author links | Discovery entry |
| **21: Adv. Search** | 22 | "Advanced" option | Modal form |
| **22: Results** | 10,20,23,31 | Book cards, back to search, author links | Search output |
| **23: Author/Narrator** | 22 | "View Author" link | Detail page |
| **24: Social Hub** | 25,26,28,29,30 | Tab navigation | Social entry |
| **25: Book Clubs** | 26,30 | Tap club, live discussion, author follow | Club view |
| **26: Live Discussion** | 25,27,29 | Host event, share moment, reviews | Event experience |
| **27: Share Clip** | 5,10,24 | Share button in player, share post feed | Modal overlay |
| **28: Challenges** | 18,24,30 | Challenge links, social feed | Gamification |
| **29: Review & Rating** | 24,26,30 | Review button, discussion posts | User-generated content |
| **30: Follow/Recs** | 24,28 | Follow readers, see activity | Social graph |
| **31: Pricing Plans** | 5,35,36,37 | "Upgrade", "Subscribe", Plan selection | Monetization entry |
| **32: Payment Method** | 33,35,36 | "Add Payment", "Billing History" | Payment hub |
| **33: Billing History** | 32,36 | "Payment Method", "Subscription" | Financial record |
| **34: Gift Codes** | 31,35 | Redeem code, gift generation | Promo entry |
| **35: Free Trial Confirm** | 32,36 | Payment processing, confirmation | Paywall modal |
| **36: Manage Subscription** | 31,32,33,35 | "Change Plan", "Payment", "Billing" | Subscription hub |
| **37: Referral Program** | 18,5,24 | "Earn Free", leaderboards, social share | Viral loop |
| **38: Accessibility** | 39,40,41,42,43 | Settings navigation | Accessibility hub |
| **39: Display & Theme** | 38,40,41,42,43 | Settings tabs | Theme settings |
| **40: Notifications** | 38,39,41,42,43 | Settings tabs | Notification prefs |
| **41: Privacy & Data** | 38,39,40,42,43 | Settings tabs | Data control |
| **42: App Settings** | 38,39,40,41,43 | Settings tabs | App behavior |
| **43: Language & Region** | 38,39,40,41,42 | Settings tabs | Localization |
| **44: Family Sharing** | 45,46,47 | Family & Kids section | Family hub |
| **45: Kids Mode** | 44,46,47 | Parental controls menu | Kids setup |
| **46: Kids Library** | 45,10 | Age-filtered browse, play | Kids discovery |
| **47: Child Profile** | 44,45 | Activity monitoring | Child stats |
| **48: User Profile** | 31,32,33,38,44,49,50,51,52 | Account tab in bottom nav | Account hub |
| **49: Edit Profile** | 48 | Edit button, save profile | Profile form |
| **50: Downloads** | 14,48 | "My Downloads" in library/settings | Storage management |
| **51: Saved Bookmarks** | 10,14,48 | "My Bookmarks", library shortcuts | Content recall |
| **52: Notification Center** | 48 | "Notifications" in account | Message history |

---

## SECTION 4: USER PERSONAS & THEIR JOURNEYS

### Persona 1: "Commuter Chris" (30-45 years old, busy professional)

**Goals:** Listen during commute (2 hrs/day), minimal friction, remembers where he was

**Typical Flow:**
```
1. Opens app during morning drive
2. PAGE 5 (Home) → Mini-player shows "The Lean Startup" at previous position
3. Taps resume → PAGE 10 (Player) starts at timestamp
4. Listens for 45 minutes while driving
5. PAGE 12 (Car Mode) - simplified controls, voice commands
6. Gets to office, closes player (saves position to cloud)
7. Lunch break: 
   → Searches for new book PAGE 20
   → Browses results PAGE 22
   → Adds to wishlist PAGE 17
8. Evening after work:
   → Checks referral rewards PAGE 37
   → Refers friend → earns credit
9. Sleeps: Sets sleep timer PAGE 10 for 30 minutes
```

**Key Features Used:** Smart Resume, Car Mode, Offline Downloads, Referral Rewards, Smart Resume

**Monetization:** Premium subscription (unlimited)

---

### Persona 2: "Student Sara" (18-22 years old, college student)

**Goals:** Learn Spanish language, notes for classes, budget-conscious

**Typical Flow:**
```
1. Enrolls in Spanish language challenge PAGE 5
2. Opens Spanish audiobook PAGE 6
3. PAGE 10 (Player) with dual-language transcript enabled
4. Takes notes on vocabulary PAGE 13 (Bookmarks)
5. Exports notes to PDF for study guide PAGE 13
6. Attends language learning community PAGE 25 (Book Club - Spanish learners)
7. Discusses challenges with other language learners PAGE 26 (Live Discussion)
8. PAGE 31 (Pricing) - Student discount verification
9. Gets premium at 40% off student price
10. Earns referral credits by inviting classmates PAGE 37
```

**Key Features Used:** Dual Language Display, Bookmarks/Notes, Book Clubs, Referral Program, Student Discount

**Monetization:** Student discount tier

---

### Persona 3: "Parent Patricia" (35-55 years old, has kids)

**Goals:** Safe kids listening, track reading, manage family library

**Typical Flow:**
```
1. Sets up family account PAGE 44
2. Adds two children (ages 8, 12)
3. Enables Kids Mode PAGE 45 with PIN protection
4. Sets age-appropriate content filtering
5. Sets daily listening limits (1 hour)
6. Subscribes to Family Plan PAGE 31
7. Children browse Kids Library PAGE 46
8. Parent monitors activity PAGE 47 (Child Profile)
9. Sets reading goals for kids
10. Parents joins book club themselves PAGE 25
11. Shares audiobook clip to social media PAGE 27
12. Discusses book in live author event PAGE 26
```

**Key Features Used:** Family Sharing, Kids Mode, Parental Controls, Reading Log, Book Clubs, Sharing

**Monetization:** Family plan subscription

---

### Persona 4: "Voracious Vera" (25-40 years old, serious reader)

**Goals:** Organize large library, notes for club discussions, community engagement

**Typical Flow:**
```
1. Has 200+ books in library
2. Creates custom shelves: "Book Club", "Favorites", "For Review", etc. PAGE 16
3. Uses filters to sort PAGE 15
4. Creates detailed notes on characters PAGE 13
5. Exports bookmarks for book club discussion PAGE 13
6. Participates in monthly reading challenge PAGE 28
7. Writes detailed reviews PAGE 29
8. Follows favorite authors PAGE 23
9. Gets notifications of new releases
10. Joins book clubs for books she likes PAGE 25
11. Hosts live discussion with other members PAGE 26
12. Competes on leaderboards PAGE 28
13. Makes referrals to expand community PAGE 37
```

**Key Features Used:** Smart Shelves, Bookmarks/Notes, Book Clubs, Reviews, Reading Challenges, Author Follow, Referrals

**Monetization:** Premium unlimited + referral credits

---

### Persona 5: "Budget Babu" (18-35 years old, price-conscious, India-focused)

**Goals:** Cheap audiobooks, episodic fiction, social features

**Typical Flow:**
```
1. Opens free tier with ads PAGE 5
2. Browses episodic fiction content (Pocket FM style) PAGE 6
3. Listens to 1 free episode PAGE 10
4. Needs to unlock next episode
5. Earns free coins via daily login bonus PAGE 5
6. Watches ads to earn additional coins
7. Uses coins to unlock episodes PAGE 10
8. Participates in daily challenges for bonus coins PAGE 28
9. Invites friends via referral PAGE 37 for more coins
10. When coins allow, subscribes to hourly plan (20 hours/month) PAGE 31
11. Uses hourly plan strategically for premium content
12. Attends free book clubs PAGE 25
13. Participates in free reading challenges PAGE 28
```

**Key Features Used:** Freemium Model, Episodic Content, Gamification (daily bonuses, challenges), Referral Program, Hourly Plan

**Monetization:** Freemium → Hourly plan + ads

---

## SECTION 5: NAVIGATION PATTERNS & BEST PRACTICES

### Bottom Navigation Behavior

```
Always Visible:
├─ [Home] → PAGE 5 (Dashboard hub)
├─ [Search] → PAGE 20 (Discovery entry)
├─ [Library] → PAGE 14 (My Library hub)
├─ [Social] → PAGE 24 (Community hub)
└─ [Account] → PAGE 48 (Settings/Profile hub)

Behavior Rules:
- Tapping active tab → Scroll to top (if on tab)
- Tapping non-active tab → Navigate to hub page
- Hidden on: Full Player (PAGE 10), Car Mode (PAGE 12), Modals
- Visible on: All other screens
```

### Back Navigation

```
Standard Pattern:
├─ Back arrow on top-left (all non-root pages)
├─ Tap → Return to previous page with scroll position preserved
├─ Exception: Full Player (PAGE 10) → Back arrow minimizes to PAGE 11 (Mini Player)

Root Pages (no back button):
├─ PAGE 5: Home (Home tab root)
├─ PAGE 20: Search (Search tab root)
├─ PAGE 14: My Library (Library tab root)
├─ PAGE 24: Social (Social tab root)
├─ PAGE 48: Account (Account tab root)
```

### Search Entry Points

```
Global Search Accessible From:
├─ Search tab (PAGE 20) - Primary
├─ Home carousel → Search recommendation
├─ Search icon in top navigation (all pages)
├─ Bottom nav [Search] tab

Search Bar Behavior:
├─ Tap → PAGE 20 opens
├─ Type query → Auto-suggestions appear
├─ Hit search → PAGE 22 (Results) shows
├─ Tap suggestion → Book detail modal
```

### Player Minimization

```
Full Player States:
├─ PAGE 10: Full screen player
├─ PAGE 11: Mini-player at bottom
├─ PAGE 12: Car mode (full screen, simplified)

Transitions:
├─ PAGE 10 → Tap back arrow → PAGE 11 (book/page minimized)
├─ PAGE 11 → Swipe up → PAGE 10 (expand to full)
├─ PAGE 11 → Swipe down → Dismiss (stop playing)
├─ PAGE 5/14/20/etc → Mini-player visible at bottom if playing
```

### Modal/Overlay Behavior

```
Standard Modals:
├─ Appear on top of current page
├─ Tap outside → Dismisses (confirm if unsaved changes)
├─ Swipe down on iOS → Dismisses
├─ Back button → Dismisses

Examples:
├─ Modal 1: Genre selection
├─ Modal 3: Rate & Review
├─ Modal 5: Add to Shelf
├─ PAGE 13: Bookmarks panel (side overlay)
├─ PAGE 27: Share clip modal
```

### Deep Linking (Universal Links)

```
For Sharing/Notifications, these deep links work:
├─ app://book/{bookId} → Opens book detail
├─ app://author/{authorId} → Opens author profile
├─ app://playlist/{playlistId} → Opens book club detail
├─ app://player/{bookId}?timestamp={time} → Resumes at timestamp
├─ app://referral/{referralCode} → Signs up with referral
├─ app://challenge/{challengeId} → Joins reading challenge
├─ app://clip/{clipId} → Plays shared audio clip

Usage:
├─ Shared audio clips (PAGE 27) include deep link
├─ Push notifications link to relevant pages
├─ Email invites use deep links to app content
```

---

## SECTION 6: EDGE CASES & ERROR FLOWS

### Error Scenarios Handled

```
Network Errors:
├─ No internet: "Playing offline. Retrying..."
├─ Connection timeout: "Connection lost. Tap to retry."
├─ Download failed: "Download interrupted. Retry?"

Payment Errors:
├─ Card declined: "Payment failed. Update payment method."
├─ Subscription lapsed: "Your subscription expired. Renew?"
├─ Failed auto-renewal: "Payment unsuccessful. Renew manually?"

Content Errors:
├─ Book unavailable: "This book is no longer available."
├─ Narrator unavailable: "This narration is not available in your region."
├─ Age-gated content: "This content requires parental approval."

App Errors:
├─ Crash recovery: Resume at last known position
├─ Sync failure: "Couldn't sync progress. Retrying..."
├─ Storage full: "Device storage full. Download limit exceeded."

Authentication Errors:
├─ Session expired: "Please log in again."
├─ Account locked: "Too many failed attempts. Try again in 30 minutes."
├─ Two-factor failed: "Verification failed. Try again."
```

### Recovery Flows

```
Download Interrupted:
1. Notification: "Download paused"
2. User taps → PAGE 50 (Downloads manager)
3. Shows incomplete download with progress bar
4. "Resume Download" button → Resumes from checkpoint
5. Completed → "Download finished" notification

Playback Interrupted:
1. App crash or user closes player
2. Position saved to cloud
3. User reopens app → PAGE 5 (Home)
4. Mini-player shows previous book
5. "Resume at 2:34:15" button
6. Tap → Continues seamlessly

Subscription Expired:
1. Notification: "Your subscription ended"
2. Premium features disabled
3. Can browse library but can't play premium books
4. "Renew" button → PAGE 31 (Pricing)
5. Resubscribe → Features re-enabled immediately
```

---

## SECTION 7: MONETIZATION FLOW INTEGRATION

### Where Paywalls Appear

```
Free-to-Paid Upsell:
├─ PAGE 5: "Upgrade to Premium" banner (if free user)
├─ PAGE 10: Premium audio quality CTA
├─ PAGE 8: Premium samples
├─ PAGE 31: Paywall when free credits exhausted
├─ Modal 10: "Feature Unlock" (premium-only features)

Subscription Selection:
├─ PAGE 31: Main pricing hub (5 plans)
├─ PAGE 35: Confirmation before purchase
├─ PAGE 32: Payment setup
├─ PAGE 36: Manage subscription (post-purchase)

Trial Flow:
├─ PAGE 35: "Start 7-day free trial" CTA
├─ Auto-renews after trial (toggleable)
├─ Reminder: "Trial ends in 2 days"
├─ Can cancel anytime via PAGE 36

Freemium Path:
├─ Free ads-supported tier (PAGE 5)
├─ Daily coin/credit bonuses
├─ Earn via challenges, streaks, referrals
├─ Use coins for episode unlocks
├─ Upsell: "Go Premium for unlimited"
```

---

## CONCLUSION & SUMMARY

This comprehensive navigation map defines:
- **70 total screens** (58 pages + 12 modals)
- **18 core user flows** covering all major journeys
- **12 edge case flows** for error handling
- **5 user personas** with their typical paths
- **Deep linking** for sharing & notifications
- **Monetization integration** throughout the app

**Key Navigation Principles:**
1. Bottom nav always visible (main entry points)
2. Clear back navigation (return to previous state)
3. Modals overlay, don't replace pages
4. Deep links enable social sharing & virality
5. Player minimization keeps music accessible
6. Error states recovered gracefully
7. Monetization integrated non-intrusively
