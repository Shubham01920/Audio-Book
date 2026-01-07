# COMPREHENSIVE PAGE ARCHITECTURE FOR AUDIOBOOK APP
## Complete UI/UX Page Specifications with Feature Mapping
**Document Version:** 1.0  
**Date:** December 26, 2025  
**Total Pages:** 58 Core Pages + 12 Modals/Overlays = **70 Total UI Screens**

---

## TABLE OF CONTENTS
1. Authentication & Onboarding (4 pages)
2. Home & Discovery (6 pages)
3. Player & Playback (5 pages)
4. Library & Collection Management (8 pages)
5. Search & Filtering (4 pages)
6. Social & Community (7 pages)
7. Monetization & Payment (9 pages)
8. Accessibility & Settings (8 pages)
9. Kids & Family (4 pages)
10. User Profile & Account (5 pages)

---

## SECTION 1: AUTHENTICATION & ONBOARDING (4 Pages)

### Page 1: **Splash Screen / App Launch**
**Features Included:**
- App logo animation
- Brand messaging ("Your Personal Audiobook Universe")
- Loading state indicator
- Auto-redirect logic (authenticated vs. unauthenticated users)

**User Flow:** Appears for 2-3 seconds on cold start

---

### Page 2: **Welcome Screen (Onboarding Step 1)**
**Features Included:**
- Welcome message with app value proposition
- Carousel of 3-4 key selling points with illustrations:
  - "Listen Anywhere" (offline downloads)
  - "Control Every Detail" (playback controls)
  - "Stay Connected" (book clubs, sharing)
  - "Learn & Grow" (language learning, gamification)
- "Continue with Email" button
- "Continue with Google" (SSO)
- "Continue with Apple" (SSO)
- "Continue with Facebook" (SSO)
- Terms of Service + Privacy Policy links

**Monetization Integration:** None yet (pure onboarding)

---

### Page 3: **Sign Up / Login Screen**
**Features Included:**
- Email field
- Password field
- "Show/Hide Password" toggle
- "Forgot Password?" link
- "Sign Up" button (if new user)
- "Log In" button (if returning user)
- "Or continue with Google/Apple/Facebook" options
- Two-Factor Authentication (optional toggle)
- Remember Me checkbox
- Terms acceptance checkbox

**Technical Requirement:**
- Form validation (email format, password strength)
- Error handling (wrong credentials, account locked, etc.)
- Session management

---

### Page 4: **Preferences / Account Setup (Onboarding Step 2)**
**Features Included:**
- **Language Selection Dropdown:** English, Hindi, Tamil, Spanish, French, etc. (matches Content Catalog Languages)
- **Region Selection Dropdown:** Country/region for pricing, content, payment methods
- **Preferred Monetization Model Choice (Optional):**
  - "Credits (Buy as you go)"
  - "Unlimited Subscription"
  - "Hourly Plan"
  - "Free with Ads"
- **Content Preference Checkboxes:**
  - Fiction / Non-Fiction / Self-Help / Kids / Educational / Audio Dramas / Courses
- **Accessibility Preference Toggle:**
  - "Enable High Contrast Mode"
  - "Enable Dyslexia Font"
  - "Enable Screen Reader Optimization"
- **Age Confirmation:** "I am 18+ / I am under 18"
- "Continue to Home" button

**Personalization Integration:**
- Dark mode / Light mode preference
- Notification preferences preview

---

## SECTION 2: HOME & DISCOVERY (6 Pages)

### Page 5: **Home / Dashboard (Main Screen)**
**Features Included:**
- **Header Section:**
  - User greeting ("Welcome, Priya!")
  - Search bar (tap to navigate to Search page)
  - Notification bell icon + unread count badge
  - User profile icon (tap to Profile page)

- **Recently Listened Section (Carousel):**
  - Book cover + title + author + "Resume at [timestamp]" label
  - Progress ring showing completion %
  - Play button overlay
  - Swipe to scroll multiple titles

- **Continue Reading Banner:**
  - Single highlighted book you're actively reading
  - Large play button
  - "13 hours 24 minutes remaining" text
  - Progress bar

- **Personalized AI Recommendations Section:**
  - "Recommended for You" heading
  - Carousel of 8-10 book cards
  - Book cover + title + author + rating stars
  - "Based on [Book Name] you loved"
  - Price/availability badge
  - Wishlist heart icon (tap to add to wishlist)

- **Trending Now Section:**
  - Horizontal scroll carousel
  - Books popular this week/month
  - Trending badge
  - Number of listeners badge

- **New Releases Section:**
  - Latest added books
  - "Coming Soon" countdown pages visible

- **Genre Shortcuts Section (Horizontal Grid):**
  - Fiction
  - Non-Fiction
  - Self-Help
  - Kids
  - Educational
  - Audio Dramas
  - Courses
  - Languages (tap to see language learning content)
  - Each has icon + tap to category page

- **Bottom Navigation Bar (Fixed):**
  - Home (active)
  - Search
  - My Library
  - Social
  - Account

**Monetization Integration:**
- "Upgrade to Premium" banner (if on free tier)
- "You have 3 credits remaining" indicator (if on credit system)

---

### Page 6: **Discover / Browse Page**
**Features Included:**
- **Header:**
  - "Discover New Books" title
  - Filter icon (tap to Filters page)
  - Sort dropdown (Popular, Newest, Highest Rated, Most Listened)

- **Featured Collection Sections (Vertical Scrolling):**
  - "Best Fiction This Month" carousel
  - "Award-Winning" carousel
  - "Trending Audio Dramas" carousel
  - "Staff Picks" carousel (curated editorial)
  - "Audiobook-Only Originals" carousel
  - "If You Liked [Book]..." personalized section

- **Spotlight / Editorial Picks:**
  - Large featured book card (60% screen height)
  - Book cover, title, author, narrator
  - Star rating + review count
  - Synopsis text
  - "Add to Wishlist" + "Listen Free Sample" buttons
  - "See Similar" button
  - Swipe left for next spotlight

- **Top Lists Section:**
  - "Best Fiction" → tap to Top 20 Fiction page
  - "Best Non-Fiction" → tap to Top 20 Non-Fiction page
  - "Most Popular" → tap to Top 50 page
  - "Award Winners" → tap to filtered list

- **Microgenre Tags Cloud:**
  - "Cozy Mystery"
  - "Romantic Suspense"
  - "Police Procedural"
  - "Paranormal Romance"
  - Tap any tag to filtered results

**Monetization Integration:**
- Premium badge on exclusive titles
- "Included with Premium" labels

---

### Page 7: **Emotional / Mood-Based Search Results**
**Features Included:**
- **Mood Selection (Initial or from Home):**
  - Mood carousel: Uplifting, Scary, Romantic, Heartbreaking, Funny, Thoughtful, Adventurous, Relaxing
  - Each mood has emoji or icon
  - Tap to apply mood filter

- **Filtered Results:**
  - Grid layout (2-column)
  - Book covers with titles, authors, ratings
  - "Based on [Mood] mood" subheading
  - Sort options

**Related Feature Pages:**
- Emotional search functionality here
- AI-powered categorization backend

---

### Page 8: **Samples / Trailers Feed**
**Features Included:**
- **Header:**
  - "Listen to Samples" title
  - Genre filter dropdown
  - Time filter (This Week, This Month)

- **Sample Card Grid (2-column):**
  - Book cover thumbnail
  - Title + Author
  - "2:35 sample" duration badge
  - Play button overlay
  - "Listen to Full Book" button
  - Add to wishlist heart

- **Sample Player (In-Page):**
  - When user taps play, inline player appears
  - Play/pause/progress bar
  - "Listen to Full Book" CTA

- **Related Recommendations:**
  - After sample plays, "You might also like..." carousel appears

**Monetization Integration:**
- Free samples for all users
- "Start 7-day Free Trial" button for premium samples

---

### Page 9: **Countdown Pages / Upcoming Releases**
**Features Included:**
- **Header:**
  - "Coming Soon" title
  - Sort by: "Release Date (Nearest First)", "Most Saved"

- **Countdown Cards (Vertical List):**
  - Book cover + title + author
  - Narrator name
  - Release date + countdown timer (X days 5 hours remaining)
  - "Notify Me" button (turns into "Notified" state)
  - Pre-order CTA (if available)
  - "Based on series [Series Name]" link (if applicable)

- **Series Continuation:**
  - Show if book is part of series
  - Link to series page

**Gamification Integration:**
- "Early Access" badge if pre-order included with subscription

---

## SECTION 3: PLAYER & PLAYBACK (5 Pages)

### Page 10: **Player / Now Playing Screen (Expanded)**
**Features Included:**

- **Header:**
  - Back arrow (minimize player)
  - Share button (tap to Share sheet)
  - More options menu (⋮)

- **Book Cover Display:**
  - Large book cover (center of screen)
  - Title + Author underneath
  - Narrator name small text
  - Current chapter / progress indicator

- **Playback Controls (Primary):**
  - Large central PLAY/PAUSE button (diameter 80px)
  - Left: 30s Rewind button
  - Right: 30s Forward button
  - Subtitle: "Chapter 5 of 24"

- **Progress Bar:**
  - Full-width seekable progress bar
  - Current timestamp on left (1:23:45)
  - Total duration on right (12:34:10)
  - Drag to seek functionality
  - Show preview thumbnails on long-press (if available)

- **Playback Settings (Secondary Controls Row 1):**
  - Speed button (1.0x, tap to popup: 0.5x, 0.75x, 1.0x, 1.25x, 1.5x, 2.0x, 3.5x)
  - Volume control (slider + Boost option)
  - EQ preset button (tap to popup: Normal, Voice Boost, Reduce Bass, Reduce Treble)
  - Car Mode toggle button

- **Advanced Audio Controls (Secondary Controls Row 2):**
  - Sleep Timer button (tap to popup: 15 min, 30 min, 60 min, End of Chapter, Off)
  - Silence Trimmer toggle (Enabled/Disabled)
  - Smart Resume toggle (Enabled/Disabled)
  - Repeat button (tap to cycle: No Repeat → Repeat Chapter → Repeat Book)

- **Bookmarks & Notes Section:**
  - Bookmark button (+ icon, tap to save bookmark with optional note)
  - Highlights button (tap to show color palette)
  - Notes button (tap to open Notes list for current book)

- **Chapter List & Navigation:**
  - "Chapters" tab showing all chapters with timestamps
  - Current chapter highlighted
  - Tap to jump to chapter

- **Transcript / Synced Text (if enabled):**
  - "Transcript" tab showing synced text with current word highlighted
  - Karaoke-style word-by-word highlighting
  - Tap to jump to timestamp in transcript

- **Queue / Next Up:**
  - "Queue" tab showing:
    - Next books in series/shelf
    - Books in custom queue
    - Tap to reorder with drag-and-drop

- **Listening Stats (Persistent Bar):**
  - "You've listened to: 2 hours 15 minutes today"
  - "3-day streak!" badge

**Monetization Integration:**
- Premium audio quality indicator
- "Unlock Higher Quality" CTA (if on lower tier)

---

### Page 11: **Mini Player / Compact Player (Bottom Sheet)**
**Features Included:**
- **Collapsed State (Bar at bottom of other screens):**
  - Book thumbnail (small, 40x40px)
  - Title + author (1 line, truncated)
  - Play/pause button
  - Forward 30s button
  - Tap to expand to full player

- **Swipe Behavior:**
  - Swipe up to expand to full player page
  - Swipe down to minimize/close

---

### Page 12: **Car Mode (Simplified Playback)**
**Features Included:**
- **Full-Screen Immersive Mode:**
  - Large book cover (30% screen)
  - GIANT Play/Pause button (center, 100px diameter)
  - Large rewind/forward buttons on sides
  - Chapter title in large text
  - Time remaining in large text (12 hours 34 minutes)
  - Progress bar (thick, easy to tap)

- **Minimal Controls:**
  - Removal of non-essential UI
  - High contrast
  - No small text
  - Tap anywhere outside buttons to hide controls (10s timeout)
  - Tap screen to show controls again

- **Voice Command Integration:**
  - Microphone button (tap to voice command)
  - "Skip forward," "Pause," "Next chapter" support

**Accessibility Focus:**
- High contrast mode
- Large touch targets
- Simplified layout

---

### Page 13: **Bookmarks & Notes Panel (Side Panel / Modal)**
**Features Included:**
- **Header:**
  - "Bookmarks & Notes" title
  - Close button

- **Tabs:**
  - "Bookmarks" tab (active by default)
  - "Highlights" tab
  - "Notes" tab

- **Bookmarks Tab Content:**
  - List of all bookmarks for current book
  - Each bookmark card shows:
    - Timestamp (1:23:45)
    - Title (if user named it)
    - Duration of clip (if custom length)
    - Text preview (first 50 chars of note)
    - Buttons: Play Clip, Edit, Delete, Share
  - Sort options: By timestamp, by chapter, by creation date
  - Search field to filter bookmarks
  - "Bookmark Folders" view toggle (show in folders vs. flat list)

- **Highlights Tab Content:**
  - All highlighted passages
  - Color-coded (yellow, blue, green, etc.)
  - Passage text + timestamp
  - Buttons: Jump to bookmark, Copy text, Delete

- **Notes Tab Content:**
  - All notes attached to bookmarks
  - Note text + timestamp
  - Buttons: Edit, Delete, Copy, Share

- **Export Button:**
  - Bottom button: "Export Bookmarks & Notes"
  - Tap to choose format: PDF, Text, Email

---

## SECTION 4: LIBRARY & COLLECTION MANAGEMENT (8 Pages)

### Page 14: **My Library (Main Library Page)**
**Features Included:**

- **Header Section:**
  - "My Library" title
  - Sort dropdown (Date Added, Alphabetical, Recently Listened, Progress)
  - Filter button (tap to Filters modal)
  - View toggle (Grid 2-column vs. List view)

- **Status Tabs (Horizontal Scroll):**
  - "All" (default, shows all books)
  - "Currently Reading" (active in-progress books)
  - "Finished" (completed books)
  - "Want to Read" (wishlist, books saved but not started)
  - "Custom Shelf" (user-created shelf names: "Road Trip," "Sci-Fi," etc.)
  - "Archived" (books user archived)

- **Books Display (Grid Layout):**
  - Book cover image
  - Title + author (2 lines, white text on cover overlay)
  - Progress ring in corner showing % completed (0-100%)
  - Overlay "3/24 chapters" or "5 hours 23 min remaining"
  - Last listened date ("Last listened 3 days ago")
  - Tap to open book detail page

- **Smart Collections (If showing "All" or specific shelf):**
  - "Continue Reading" section (pinned at top)
  - Books grouped by status or custom shelf

- **Empty State (If library is empty):**
  - Illustration
  - "Your library is empty"
  - "Explore books to get started" button → Discover page

- **Action Sheet (Long-press on book):**
  - Move to Shelf
  - Add to Custom Shelf
  - Remove from Library
  - Mark as Finished
  - Mark as DNF (Did Not Finish)
  - Archive

**Monetization Integration:**
- If no active subscription visible at top: "Your free trial ends in 5 days" banner

---

### Page 15: **Library Filters & Sorting Modal**
**Features Included:**

- **Header:**
  - "Filters" title
  - Clear Filters button (reset all)
  - Apply button (bottom, fixed)

- **Filter Sections (Vertical Scroll):**
  - **Genre Filter (Checkbox list):**
    - Fiction, Non-Fiction, Self-Help, Mystery, Romance, Sci-Fi, Fantasy, Kids, Courses, etc.
    - Multiple selections allowed

  - **Duration Filter (Slider or preset buttons):**
    - Buttons: Under 5 hours, 5-10 hours, 10-20 hours, 20+ hours

  - **Status Filter (Radio buttons):**
    - Currently Reading, Finished, Want to Read, DNF, Not Started

  - **Language Filter (Checkbox):**
    - English, Hindi, Tamil, Spanish, French, etc.

  - **Narrator Filter (Searchable list):**
    - Search narrators you follow
    - Checkboxes for each

  - **Rating Filter (Star icons):**
    - 4+ stars, 3.5+ stars, 3+ stars, All ratings

  - **Release Date Filter (Date range picker):**
    - Last 30 days, Last 3 months, Last year, All time

  - **Content Type Filter (Radio):**
    - Unabridged, Abridged, AI-Narrated, Audio Drama, Courses

---

### Page 16: **Create / Manage Custom Shelves Modal**
**Features Included:**

- **Current Shelves List:**
  - "Road Trip" (32 books)
  - "Fiction" (156 books)
  - "For Later" (42 books)
  - Buttons: Edit, Delete, View
  - Drag to reorder shelves

- **Create New Shelf Button:**
  - Tap to input shelf name
  - Choose icon (optional)
  - Create button

- **Rename/Delete Options:**
  - Long-press shelf to reveal Rename, Delete, Change Icon options

---

### Page 17: **Wishlist / Want to Read Page**
**Features Included:**

- **Header:**
  - "Wishlist" title
  - Sort options (Popular, Price: Low to High, Most Saved, Newest)
  - Filter button

- **Book Cards (Grid 2-column):**
  - Book cover
  - Title, author, price (if applicable)
  - "Save for Later" heart (filled, indicating saved)
  - Price badge (if on sale) + discount percentage
  - Add to Cart / Buy button
  - Remove from Wishlist (long-press)

- **Price Alert Feature:**
  - Toggle at top: "Enable Price Alerts"
  - When enabled, show bell icon on books
  - Notify when price drops below X amount (user-set threshold)

- **Empty State:**
  - "No saved books yet"
  - "Explore to add books to your wishlist" button

---

### Page 18: **Reading Log / Statistics Page**
**Features Included:**

- **Header:**
  - "Your Listening Stats" title

- **Overview Cards (Horizontal Scroll):**
  - "Books Finished This Year" - Large number + trend
  - "Total Listening Hours" - Large number + daily average
  - "Current Streak" - Days counter + flame icon
  - "Longest Streak" - Previous record

- **Listening Time Graph:**
  - Monthly bar chart (Jan-Dec)
  - Shows hours/month
  - Tap bar for details

- **Top Statistics:**
  - Favorite genre (pie chart)
  - Most-listened narrator
  - Average book duration
  - Average speed (user's preferred playback speed)

- **Books List:**
  - "Books Finished This Year" section
  - Chronological list with completion date
  - Book cover + title + author + finish date
  - Rating (if user rated)

- **Yearly Summary (If applicable):**
  - "2024 Listening Wrap-Up"
  - "You listened to 47 books, 312 hours total"
  - "Your favorite genre was Science Fiction"
  - Share wrap-up button (to social)

---

### Page 19: **Series Grouping & Series Detail Page**
**Features Included:**

- **Series List Page (from Library):**
  - Header: "Series"
  - List of all series user is reading/has read
  - Each series card shows:
    - Series cover/icon
    - Series name
    - "Book 3 of 5" progress indicator
    - Number of books
    - Average rating
    - Tap to series detail page

- **Series Detail Page:**
  - Series title + cover/banner
  - Description of series
  - Books in series (chronological order):
    - Book 1: [Title] - Status: Finished
    - Book 2: [Title] - Status: Currently Reading (with progress %)
    - Book 3: [Title] - Status: Not Started
  - Each book shows:
    - Cover + title + author
    - Release date
    - Rating
    - Duration
    - Buttons: Play/Resume, Move to Shelf, Remove
  - "Continue Reading Next Book" prominent CTA

---

## SECTION 5: SEARCH & FILTERING (4 Pages)

### Page 20: **Search / Explore Page**
**Features Included:**

- **Search Bar (Top):**
  - Large search input
  - Search icon on left
  - Clear (X) button on right
  - Placeholder: "Search books, authors, narrators..."

- **Recent Searches:**
  - List of last 5 searches
  - User can tap to re-search or swipe to delete

- **Search Suggestions (As user types):**
  - Autocomplete from catalog database
  - Grouped by category:
    - "Books matching 'Dune'"
    - "Authors matching 'Frank Herbert'"
    - "Narrators matching 'Tim Curry'"
    - "Tags matching 'Science Fiction'"

- **Search Results Page (When user searches):**
  - Tabs: "All Results", "Books", "Authors", "Narrators", "Genres"
  - Grid of results
  - Sort/filter options
  - Pagination or infinite scroll

---

### Page 21: **Advanced Search / Filters Page**
**Features Included:**

- **Multi-Field Search Form:**
  - Title search field
  - Author name field
  - Narrator name field
  - ISBN field (if applicable)

- **Filter Sections (matching Library Filters):**
  - Genre multi-select
  - Duration range slider
  - Language select
  - Content type (Unabridged, Abridged, AI-Narrated, etc.)
  - Narrator filter (searchable)
  - Release date range
  - Rating range
  - Price range (slider: $0-$50)

- **Sort Options:**
  - Relevance, Newest, Highest Rated, Most Popular, Price (Low-High)

- **Search Button (Bottom):**
  - "Apply Filters & Search"

---

### Page 22: **Search Results Page**
**Features Included:**

- **Results Header:**
  - "Found 234 results for 'Dune'"
  - "Refine Search" link (back to advanced search)
  - Sort dropdown
  - View toggle (grid vs. list)

- **Book Grid (2-column):**
  - Book covers + titles + authors + ratings
  - Pagination or infinite scroll
  - Load more button at bottom

- **No Results State:**
  - Illustration
  - "No books found"
  - Suggestions for refining search
  - Browse categories link

---

### Page 23: **Author / Narrator Detail Page**
**Features Included:**

- **Profile Header:**
  - Author/Narrator name + photo
  - Bio/description
  - Follow button (toggle state)
  - Share button

- **Statistics:**
  - Number of books/narrations
  - Average rating
  - Most popular book

- **Books Section:**
  - List of all books by author/narrated by narrator
  - Sort options
  - Grid layout

- **Related:**
  - Similar authors/narrators
  - Readers who liked this author also liked...

---

## SECTION 6: SOCIAL & COMMUNITY (7 Pages)

### Page 24: **Social / Community Hub**
**Features Included:**

- **Header:**
  - "Community" or "Social" title
  - Notification bell icon

- **Tabs (Horizontal Scroll):**
  - "For You" (default, personalized feed)
  - "Book Clubs"
  - "Following" (people you follow)
  - "Trending"

- **"For You" Feed:**
  - Posts from users you follow
  - Book club discussions
  - Shared clips/highlights
  - Reading challenges your friends joined
  - Book reviews from your network
  - Each post card shows:
    - User avatar + name + timestamp
    - Post content (text or shared clip)
    - Book title (if relevant)
    - Like count + comment count + share button
    - Tap to expand full post

- **Create Post Button (Floating Action Button):**
  - Tap to create new post modal

---

### Page 25: **Book Clubs Page**
**Features Included:**

- **Header:**
  - "Book Clubs" title
  - Filter (All, Joined, My Clubs, Recommended)
  - Sort (Active, Newest, Most Members)

- **Book Club Cards:**
  - Club name + icon
  - Current book being discussed
  - Member count (avatar group)
  - Next discussion date
  - Description (1 line)
  - "Join" or "View" button
  - Tap to club detail page

- **Create Club Button:**
  - Floating action button
  - Tap to create new club modal

- **Book Club Detail Page:**
  - Club name + cover image + description
  - "Join Club" button (if not member)
  - "Leave Club" button (if member)
  - Members section (list of avatars + names)
  - Current book being discussed with cover, synopsis
  - Discussion/Chat section:
    - Messages from members (threaded conversation)
    - Post new message input
    - Reactions to messages (likes, emoji reactions)
  - Schedule section:
    - Next discussion session date + time
    - Past discussion archive
    - "Join Live Discussion" button (if happening now)

---

### Page 26: **Live Discussion / Story Circle Page**
**Features Included:**

- **Live Event Header:**
  - "Live Discussion - The Six of Crows"
  - "Hosted by: [Author Name]"
  - Live indicator badge (red pulsing)
  - Participant count ("2.3K listening")
  - Share this event button

- **Chat / Q&A Section (Bottom 50% of screen):**
  - User messages/questions from chat
  - Timestamp for each message
  - User avatars
  - Highlighted Q&A from author (different color background)
  - "Ask a Question" input field (bottom)
  - Reactions (like, heart, fire emojis)

- **Host Video / Audio (Top 50%):**
  - Host camera feed (author/creator)
  - OR audio waveform if audio-only
  - Mute/unmute button for audio

- **Interactive Elements:**
  - Poll widget (if host creates poll)
  - Reactions bar (emoji reactions float up screen)
  - "Raise Hand" button to ask question

- **Recording Notice:**
  - "This event is being recorded"

---

### Page 27: **Share Audio Clip Modal**
**Features Included:**

- **Header:**
  - "Share This Moment" title
  - Close button

- **Clip Details:**
  - Book cover thumbnail
  - Title + author
  - Duration of clip being shared
  - "00:15 - 00:45 of Chapter 5"

- **Share Options:**
  - Instagram Stories (with share preview)
  - Instagram Feed (with share preview)
  - Twitter/X (with share preview)
  - Facebook (with share preview)
  - WhatsApp
  - Email
  - Copy link
  - Messages

- **Clip Customization (before sharing):**
  - Add caption text field
  - Add sticker/emoji overlay
  - Choose playback speed to include

- **Share Button:**
  - "Share to [Platform]"

---

### Page 28: **Reading Challenge / Community Challenge Page**
**Features Included:**

- **Challenge Header:**
  - "2025 Reading Challenge: Read 50 Books"
  - Days remaining countdown
  - Your progress (visual bar: "23 of 50 books")
  - Leaderboard position ("You're 12th out of 1,234 participants")

- **Challenge Details:**
  - Challenge rules
  - Rewards for completion
  - Start and end dates
  - Books you've logged for challenge

- **Leaderboard:**
  - Top 10 users by progress
  - Each entry shows:
    - Rank number
    - User avatar + name
    - Books completed / goal
    - Progress bar
    - Current points/badges earned
  - Your rank highlighted

- **Invite Friends Button:**
  - "Invite Friends to Challenge"
  - Opens share modal

- **Join Button (if not joined):**
  - Large "Join Challenge" CTA

---

### Page 29: **Review & Rating Page**
**Features Included:**

- **Review Input Section:**
  - Book title + cover (top)
  - Star rating selector (1-5 stars, tap to rate)
  - Review title text field ("Amazing read!")
  - Review text field (multi-line, placeholder: "Share your thoughts...")
  - Character count (200/1000 characters)

- **Spoiler Warning Toggle:**
  - "This review contains spoilers"
  - When enabled, review is hidden by default with "Show Review" button

- **Post Review Button:**
  - "Post Review" CTA

- **Review List (Below input, existing reviews):**
  - User avatar + name + timestamp
  - Star rating
  - Review title + text
  - Like count + comment count
  - Reply button to review
  - Helpful/Not Helpful votes

---

### Page 30: **Follow / Recommendations Page**
**Features Included:**

- **Follow Readers Section:**
  - Search field: "Search for readers"
  - Suggested readers to follow
  - Each reader card shows:
    - Avatar + name
    - "Reads [Genre]" subtitle
    - Shared interests
    - "Follow" button
  - Your followers count (badge)
  - Your following count (badge)

- **Reading Activity Feed (If following people):**
  - Timeline of people you follow
  - Posts: "Sarah finished [Book]"
  - Posts: "[User] gave [Book] 5 stars"
  - Posts: "[User] joined book club: [Club Name]"

---

## SECTION 7: MONETIZATION & PAYMENT (9 Pages)

### Page 31: **Pricing / Subscription Plan Selection Page**
**Features Included:**

- **Header:**
  - "Choose Your Plan" title
  - "Start free trial" info text

- **Plan Cards (Vertical Stack, each card spans full width):**

  **Plan 1: Free with Ads**
  - Price: $0/month
  - "Current Plan" badge (if on free)
  - Features list:
    - ✓ Listen to public library books
    - ✓ 2 free audiobooks per month
    - ✓ Ads between chapters (or feature insertions)
    - ✗ No offline listening
    - ✗ Basic playback (no advanced controls)
  - "Continue Free" button (if on plan)
  - "Upgrade" button (if not on plan)

  **Plan 2: Credits (Audible-style)**
  - Price: Starting $14.99/month (1 credit)
  - "Most Popular" badge
  - Features list:
    - ✓ 1 credit per month (buy any audiobook)
    - ✓ Keep books forever (own them)
    - ✓ Premium customer service
    - ✓ Exclusive Originals
    - ✓ Full advanced playback controls
    - ✓ Offline downloads
    - ✓ Cross-device sync
  - "Start 30-Day Free Trial" button
  - "Switch to This Plan" button (if on different plan)
  - Pricing options: Monthly ($14.99), Annual ($139.99/year) with "Save 23%" badge

  **Plan 3: Unlimited Streaming**
  - Price: $12.99/month
  - Features list:
    - ✓ Unlimited listening (full catalog)
    - ✓ No credit system
    - ✓ Offline downloads (limited to 10 books)
    - ✓ All playback features
    - ✓ Ad-free listening
    - ✗ Cannot own books (license only)
  - "Start 14-Day Free Trial" button
  - Pricing options: Monthly, Annual
  - Most cost-effective badge

  **Plan 4: Hourly Plan**
  - Price: $9.99/month (20 hours)
  - Features list:
    - ✓ 20 hours listening/month
    - ✓ Additional hours available for $0.99 each
    - ✓ Offline downloads
    - ✓ Standard playback
    - ✓ Ad-free
  - "Upgrade to Unlimited" upsell
  - Pricing options: 20 hours, 50 hours

  **Plan 5: Family Plan**
  - Price: $19.99/month
  - Features list:
    - ✓ Up to 4-6 family members
    - ✓ Each member gets full unlimited access
    - ✓ Shared library (optional)
    - ✓ Parental controls
  - "Switch to Family Plan" button
  - "Learn more about Family Sharing" link

- **FAQ Section at Bottom:**
  - "What's included with Premium?"
  - "Can I switch plans?"
  - "What happens after free trial?"

---

### Page 32: **Payment Method / Billing Details Page**
**Features Included:**

- **Header:**
  - "Payment Method" title
  - Edit button

- **Current Payment Method:**
  - Card type (Visa, Mastercard, American Express)
  - Card preview (last 4 digits)
  - Expiry date
  - "Edit" button (change card)
  - "Delete" button (remove, if backup exists)

- **Add Payment Method:**
  - "Add New Payment Method" button (if no method or adding backup)
  - Payment method options:
    - Credit/Debit Card
    - Apple Pay
    - Google Pay
    - PayPal
    - Bank Account (if region-supported)

- **Billing Address (If needed):**
  - Country selector
  - Address fields
  - Save button

- **Billing History Link:**
  - "View Billing History" (navigates to Page 33)

---

### Page 33: **Billing History / Invoice Page**
**Features Included:**

- **Header:**
  - "Billing History" title
  - Download all invoices button

- **Invoice List:**
  - Chronological list of charges
  - Each invoice shows:
    - Date
    - Plan name
    - Amount charged
    - Status (Paid, Pending, Failed)
    - Download invoice button (PDF)
    - View details button

- **Subscription Details Section:**
  - Renewal date
  - Next charge amount
  - Auto-renewal toggle (on/off)
  - Cancel subscription button (red, prominent)

---

### Page 34: **Promotional Code / Gift Code Page**
**Features Included:**

- **Header:**
  - "Redeem a Code" or "Gift Codes" title

- **Code Input Section:**
  - Text field: "Enter a gift or promotional code"
  - "Redeem" button
  - Error state: "Invalid code" (if code incorrect)
  - Success state: "Code redeemed! 1 month of Unlimited added to your account"

- **Gift Code Display (If user has gift codes to share):**
  - Your gift codes section
  - Each code card shows:
    - Code (formatted: XXXX-XXXX-XXXX)
    - Plan it unlocks
    - Expiry date
    - "Copy" button
    - "Share" button
    - "Send via Email" button
    - "Revoke" button

- **Generate Gift Code Button:**
  - "Create Gift Code" (if feature available for premium users)
  - Tap to modal:
    - Select plan to gift
    - Select duration (1 month, 3 months, etc.)
    - Generate button → displays shareable code

---

### Page 35: **Free Trial Confirmation Page**
**Features Included:**

- **Header:**
  - "Confirm Free Trial" title

- **Plan Summary:**
  - Plan name + price (shows as free)
  - "Free for 7 days, then $14.99/month"
  - What's included checklist

- **Confirmation Details:**
  - Billing starts on [Date]
  - Auto-renewal toggle (with explanation)
  - Cancel anytime text
  - T&C + Privacy acceptance checkbox

- **Buttons:**
  - "Start Free Trial" (primary)
  - "Not Now" or "Back" (secondary)

---

### Page 36: **Manage Subscription Page**
**Features Included:**

- **Current Subscription Card:**
  - Plan name + renewal date
  - Amount charged
  - "Next Billing Date: January 15, 2026"

- **Quick Actions:**
  - "Change Plan" button → Plan selection page
  - "Pause Subscription" button → Pause modal
  - "Cancel Subscription" button → Cancel confirmation modal

- **Pause Subscription Modal:**
  - Reason for pause (dropdown)
  - "Pause for 1 month / 3 months" option
  - "I'll be back" message
  - Confirm button

- **Cancel Subscription Modal:**
  - "Are you sure?" headline
  - Offer: "Switch to Unlimited instead?" with price comparison
  - Reason for cancellation (dropdown)
  - Offer survey: "What could we have done better?"
  - "Confirm Cancellation" button (red)
  - "Keep My Subscription" button (secondary)

- **Billing Management Section:**
  - Link to Payment Method (Page 32)
  - Link to Billing History (Page 33)
  - Download app guide link

---

### Page 37: **Referral Rewards Program Page**
**Features Included:**

- **Program Header:**
  - "Refer & Earn" title
  - Your referral link display (with copy button)

- **Referral Statistics:**
  - "Friends Referred: 3"
  - "Credits Earned: 45 credits"
  - "Redemptions: 2"

- **How It Works Section:**
  - "Share your link → Friend signs up → You earn 1 month free"
  - Step-by-step explanation

- **Share Options:**
  - "Invite via Email" button
  - "Copy Link" button
  - "Share on Social" (Instagram, Twitter, WhatsApp, etc.)
  - QR code display (scannable)

- **Referral History:**
  - List of referred friends
  - Name, date referred, reward status
  - "Pending," "Completed," or "Expired"

---

## SECTION 8: ACCESSIBILITY & SETTINGS (8 Pages)

### Page 38: **Accessibility Settings Page**
**Features Included:**

- **Header:**
  - "Accessibility" title

- **Visual Settings Section:**
  - **Dyslexia Font Toggle:**
    - Toggle on/off
    - Sample text showing OpenDyslexic font
    - Link to accessibility info

  - **High Contrast Mode Toggle:**
    - Increases contrast for all UI elements
    - Preview of high contrast version
    - Toggle on/off

  - **Text Size Adjuster:**
    - Slider: Small → Large
    - Preview text scales in real-time
    - Save setting

  - **Color Blind Filters:**
    - Dropdown: None, Protanopia, Deuteranopia, Tritanopia
    - Explains each filter
    - Toggle on/off

  - **Theme Accessibility:**
    - "Reduce Motion" toggle (disables animations)
    - "Increase Brightness" toggle

- **Audio Settings Section:**
  - **Screen Reader Optimization:**
    - Toggle on/off
    - "Works with VoiceOver (iOS) and TalkBack (Android)"
    - Test button (reads sample text)

  - **Captions/Transcripts:**
    - "Enable Closed Captions" toggle
    - "Always show transcripts" toggle
    - Transcript text size slider

  - **Audio Description:**
    - "Enable audio descriptions for visual content"
    - Toggle on/off

  - **Keyboard Navigation:**
    - "Enable keyboard navigation" toggle
    - Explains how to navigate with keyboard
    - Shortcut cheat sheet button

- **Learning Support:**
  - **Slow Speech Option:**
    - Dropdown: Normal (1.0x), Slow (0.75x), Very Slow (0.5x)
    - Preview narration at selected speed

- **Links at Bottom:**
  - "Accessibility Guide" (external link to help docs)
  - "Report Accessibility Issue" (feedback form)

---

### Page 39: **Display & Theme Settings Page**
**Features Included:**

- **Header:**
  - "Display & Theme" title

- **Theme Selection:**
  - Radio buttons:
    - Light mode (preview shows light UI)
    - Dark mode (preview shows dark UI)
    - Auto (follows system settings)
  - Visual preview of current selection

- **Color Scheme (Beyond Dark/Light):**
  - Dropdown with presets: Default, Ocean Blue, Forest Green, Sunset Orange, Lavender
  - Color picker for custom theme (tap to open color picker)
  - Preview screen updates with chosen colors

- **Typography Settings:**
  - Default font: System font, Custom fonts (if available)
  - Line spacing: Compact, Normal, Relaxed
  - Letter spacing: Tight, Normal, Loose
  - Preview text updates

- **UI Scale:**
  - Slider: Compact → Spacious
  - Affects button sizes, spacing, text size

---

### Page 40: **Notification Settings Page**
**Features Included:**

- **Header:**
  - "Notifications" title

- **Push Notifications Section:**
  - **New Releases from Authors I Follow:**
    - Toggle on/off
    - Frequency dropdown (Immediately, Daily Digest, Weekly Digest, Off)

  - **Book Club Invitations:**
    - Toggle on/off

  - **Live Discussion Reminders:**
    - Toggle on/off
    - "Notify me [15 minutes, 1 hour, 1 day] before event starts"

  - **Streak Reminders:**
    - Toggle on/off
    - Time of day selector (if enabled)
    - "Remind me to listen to maintain my streak"

  - **Book Recommendations:**
    - Toggle on/off
    - Frequency (Daily, Weekly, Monthly)

  - **Social Activity:**
    - Toggle on/off
    - "Notify me when [friends like my reviews, friends finish books, etc.]"

  - **Promotional / Marketing Emails:**
    - Toggle on/off
    - "Receive special offers and new feature announcements"

  - **Billing Notifications:**
    - Toggle on/off (usually required)
    - "Notify me about upcoming charges, failed payments"

- **Email Preferences:**
  - Checkbox: "Also send these notifications to email"
  - Email address display

- **Notification Sound & Vibration:**
  - Sound toggle on/off
  - Sound selection dropdown
  - Vibration toggle on/off
  - Test button (plays sample notification)

---

### Page 41: **Privacy & Data Settings Page**
**Features Included:**

- **Header:**
  - "Privacy & Data" title

- **Data Sharing Section:**
  - **Share Listening Activity:**
    - Dropdown: Private (only me), Friends, Public
    - Explanation of each level

  - **Share Ratings & Reviews:**
    - Toggle on/off
    - "Others can see my reviews"

  - **Share Reading Progress:**
    - Toggle on/off
    - "Others can see which books I'm reading"

- **Advertising & Personalization:**
  - **Personalized Ads:**
    - Toggle on/off
    - "Allow personalized advertising based on listening history"

  - **Interest-Based Recommendations:**
    - Toggle on/off
    - "Show me recommendations based on my listening"

- **Data Access & Download:**
  - **Export My Data:**
    - Button: "Download My Data"
    - Format options (CSV, JSON, PDF)
    - Includes: Library, bookmarks, notes, activity, preferences
    - Downloadable as ZIP file

  - **Data Deletion Options:**
    - Button: "Request Data Deletion" (for GDPR/privacy compliance)
    - Confirmation required
    - Explains what gets deleted

- **Third-Party Integration:**
  - **Connected Apps:**
    - List of apps with permissions (Spotify, Goodreads, Apple Books)
    - "Disconnect" button for each
    - "Connect New App" button

- **Privacy Policy & T&C Links:**
  - "Privacy Policy" (external link)
  - "Terms of Service" (external link)
  - "Cookie Preferences" (external link)

---

### Page 42: **App Settings & Preferences Page**
**Features Included:**

- **Header:**
  - "App Settings" title

- **App Behavior Section:**
  - **Offline Listening Defaults:**
    - "Auto-download next book in series" toggle
    - "Auto-download during WiFi only" toggle
    - Max storage for downloads slider (500MB - 5GB)

  - **Autoplay Settings:**
    - "Continue with next book in queue" toggle
    - "Ask before autoplay" radio button
    - Choose default queue order (Series → Personal Library → Recommendations)

  - **Streaming Quality (Default):**
    - Dropdown: Low (128kbps), Normal (192kbps), High (320kbps), Lossless (FLAC)
    - Warning if high quality uses more data

  - **Resume Behavior:**
    - "Resume at exact second" toggle
    - "Resume position timeout" slider (auto-reset if not opened in X days)

  - **Data Saver Mode:**
    - Toggle on/off
    - "Reduces streaming quality and disables automatic sync"

  - **Auto-Update Settings:**
    - Dropdown: Update Immediately, Ask When Available, WiFi Only

- **App Information:**
  - App version number
  - Build number
  - Changelog button
  - Check for updates button

- **Device Info:**
  - OS version
  - Device model
  - Storage space available
  - Clear cache button ("Free up [X]MB of space")

---

### Page 43: **Language & Region Settings Page**
**Features Included:**

- **Header:**
  - "Language & Region" title

- **App Language:**
  - Dropdown showing all supported languages
  - Currently selected highlighted
  - Selection changes app UI language immediately
  - Languages: English, Hindi, Tamil, Telugu, Spanish, French, German, Portuguese, etc.

- **Content Language:**
  - Multi-select checkboxes
  - "Show audiobooks in these languages"
  - Allows selecting primary + secondary languages
  - Affects catalog/recommendations

- **Region/Country:**
  - Dropdown selector
  - "Used for pricing, content availability, payment methods"
  - Changing region might change prices/plans

- **Currency:**
  - Dropdown (auto-set by region, can override)
  - Shows: USD, EUR, GBP, INR, etc.

- **Narration Accent Preference:**
  - Radio buttons: American English, British English, Indian English, Australian English, etc.
  - Used for recommendations/voice selection

- **Text Display:**
  - "Romanization Option" (if applicable for non-Latin scripts)
  - Toggle: Show Hindi/Tamil text as Romanized (IAST)

---

## SECTION 9: KIDS & FAMILY (4 Pages)

### Page 44: **Family Account / Family Sharing Setup**
**Features Included:**

- **Header:**
  - "Family Sharing" title

- **Your Family Members:**
  - List of added family members (up to 4-6)
  - Each member shows:
    - Avatar/name
    - Age (or DOB)
    - Role (Adult/Parent, Child/Kid)
    - Email or phone
    - "Remove from Family" button
    - "Change Parental Controls" button

- **Add New Family Member:**
  - Button: "Add Family Member"
  - Tap to modal:
    - Input name
    - Input email or phone
    - Select role (Adult, Child 7-12, Child 13-17)
    - Send invitation button (email invite sent)
    - Option to generate invite link

- **Family Sharing Status:**
  - "Shared Library" toggle (on/off)
  - If on: "All family members can access books purchased by anyone"
  - If off: "Each member maintains private library"

- **Family Sharing Details:**
  - "Billing managed by: [Primary account holder name]"
  - Cost: "$19.99/month for up to 6 people"
  - Savings badge: "Save 30% vs. individual subscriptions"

- **Manage Billing:**
  - "Change payment method" link
  - "View family billing" link

---

### Page 45: **Kids Mode / Parental Controls Page**
**Features Included:**

- **Header:**
  - "Kids Mode & Parental Controls" title

- **Kids Mode Toggle:**
  - Large toggle: Enable/Disable Kids Mode
  - When on: Red warning indicator
  - When enabled: 4-digit PIN setup required (to prevent kids from disabling)

- **PIN Setup / Change:**
  - Current PIN status
  - "Change PIN" button (tap to input current PIN, then new PIN)

- **Age-Based Content Filtering:**
  - Radio buttons:
    - Kids (3-5 years)
    - Kids (6-8 years)
    - Kids (9-11 years)
    - Teens (12-14 years)
    - Teens (15-17 years)
  - Auto-filters audiobooks by content rating
  - Example: "Age 6-8 will only see books rated for that age"

- **Curated Kids Library:**
  - Link: "Browse Kids Library"
  - Pre-selected safe, age-appropriate books
  - Organized by age range

- **Screen Time Limits:**
  - Toggle: "Enforce screen time limits"
  - When on:
    - Daily limit slider (15 min - 2 hours)
    - Set allowed listening times (e.g., 3 PM - 8 PM)
    - "Break reminders" (every 30 min: "Take a 5 min break")

- **Content Restrictions:**
  - Checkboxes:
    - Block explicit content
    - Block social features (messaging, comments)
    - Block shopping/in-app purchases
    - Block access to certain categories (e.g., "Restrict adult fiction")

- **Activity Monitoring:**
  - "View [Child Name]'s Activity"
  - Shows:
    - Books listened to today
    - Total listening time today
    - Listening streak
    - Recommended books for age
    - Reading goals progress

---

### Page 46: **Kids Content Library / Curated Kids Browse**
**Features Included:**

- **Header:**
  - "Kids Audiobooks" title
  - Age filter tabs: "Ages 3-5", "Ages 6-8", "Ages 9-11", "Ages 12-14", "Ages 15-17"

- **Curated Collections (By Age):**
  - "Best for This Age"
  - "Award-Winning Kids Books"
  - "Series for Kids"
  - "Educational Audiobooks"
  - "Fairy Tales & Classics"
  - "Adventure Stories"
  - "Funny & Silly"

- **Book Cards:**
  - Cover + title + author + age recommendation
  - Parent rating (stars from other parents)
  - Duration
  - "Add to [Child Name]'s Library" button

- **Safe Listening Indicators:**
  - Green check mark on content that's safe
  - Content rating badge

---

### Page 47: **Child Profile / Activity Dashboard**
**Features Included:**

- **Header:**
  - "[Child Name]'s Activity" title
  - Edit profile button

- **Quick Stats:**
  - Listening time today
  - Listening streak
  - Books finished this month

- **Today's Activity:**
  - Timeline showing what they listened to
  - Books they started/resumed
  - Time spent on each book
  - Notifications for usage milestones

- **Listening Goals (Set by Parent):**
  - "Read 1 book this month"
  - "Listen 30 minutes per week"
  - Progress towards goals (with celebration when completed)

- **Recommended for Them:**
  - Books suggested based on age & listening history
  - "Start Listening" button for each

- **Insights:**
  - Favorite genre
  - Most-listened narrator
  - Preferred listening time of day

---

## SECTION 10: USER PROFILE & ACCOUNT (5 Pages)

### Page 48: **User Profile / Account Home Page**
**Features Included:**

- **Header:**
  - "Account" title

- **Profile Card (Top):**
  - Profile picture (tap to change)
  - User name (tap to edit)
  - Email address
  - Member since: [Date]
  - Edit Profile button

- **Quick Status Cards (Horizontal Scroll):**
  - Current subscription status ("Premium Member, Renews Jan 15")
  - Books in library ("47 books")
  - Current streak ("5-day listening streak")
  - Reading goal progress ("23 of 50 books in 2025")

- **Menu Sections:**
  - **My Account**
    - Edit Profile (Page 49)
    - My Payment Methods (Page 32)
    - Billing History (Page 33)
  
  - **Preferences**
    - Display & Theme (Page 39)
    - Notifications (Page 40)
    - Privacy & Data (Page 41)
    - App Settings (Page 42)
    - Language & Region (Page 43)
    - Accessibility (Page 38)
  
  - **Family & Kids**
    - Family Sharing (Page 44)
    - Kids Mode & Controls (Page 45)
  
  - **Help & Support**
    - Help & FAQ
    - Contact Support
    - Report an Issue
    - Rate App
  
  - **Logout**
    - Log Out button (bottom, red)
    - "Delete Account" button (very bottom, if offered)

---

### Page 49: **Edit Profile Page**
**Features Included:**

- **Header:**
  - "Edit Profile" title
  - Save button (top-right)

- **Profile Picture:**
  - Current picture (circular, large)
  - "Change Photo" button
  - Options: Take Photo, Choose from Library, Remove Photo

- **Name Fields:**
  - First Name text input
  - Last Name text input

- **Bio (Optional):**
  - Text field (max 160 chars)
  - Placeholder: "Tell us about your reading interests..."
  - Char count (50/160)

- **Public Profile:**
  - Toggle: "Make profile public"
  - When on: Other users can view your profile, reviews, reading activity
  - When off: Only friends can see profile (or only you)

- **Social Verification (Optional):**
  - Connect social accounts (Twitter, Instagram, Goodreads)
  - Buttons: "Connect [Platform]"
  - Shows connected accounts with checkmarks

- **Email Address:**
  - Display only (non-editable)
  - "Change email" link (for security reasons)

- **Phone Number (Optional):**
  - Input field
  - Used for recovery + notifications
  - Verify button (sends code to phone)

- **Date of Birth:**
  - Month / Day / Year selectors (for age-gating)

- **Gender (Optional):**
  - Dropdown: Prefer not to say, Male, Female, Other

- **Save Changes Button:**
  - "Save Profile Changes" (bottom)

---

### Page 50: **My Downloads / Offline Content Manager**
**Features Included:**

- **Header:**
  - "My Downloads" title
  - Sort: By name, By date, By size
  - Storage info: "Using 2.5 GB of 5 GB allowed"

- **Downloaded Books List:**
  - Book cover + title + author
  - Download date
  - File size
  - Download progress (if in-progress): Progress bar + percentage
  - Status: Downloaded, Downloading, Queued, Failed
  - Buttons: Resume Download, Cancel, Delete
  - Long-press to select multiple for bulk delete

- **Storage Management:**
  - "Clear Space" button
  - Shows suggested books to delete (oldest first, least listened to)
  - Recommend clearing to free up space if > 80% full

- **Download Settings:**
  - Auto-download settings link (to App Settings)
  - "Download over cellular" toggle (default off, recommends WiFi only)
  - "Download next book in series automatically" toggle

- **Empty State (If no downloads):**
  - Illustration
  - "No downloaded books"
  - "Download books for offline listening" button

---

### Page 51: **Saved / Bookmarked Books & Passages**
**Features Included:**

- **Tabs (Horizontal Scroll):**
  - "Bookmarks" (default)
  - "Highlights"
  - "Clips"
  - "Notes"

- **Bookmarks Tab:**
  - List of all bookmarks across all books
  - Each bookmark card shows:
    - Book cover thumbnail
    - Bookmark title (if named)
    - Timestamp + duration
    - Text preview
    - "Listen to Clip" button
    - "Jump to Book" button
    - "Delete" option (long-press)

- **Highlights Tab:**
  - All color-coded highlights
  - Book title + chapter
  - Highlighted text
  - Color indicator
  - "Jump to" button

- **Clips Tab:**
  - All saved custom clips
  - Book + duration
  - Buttons: Play, Edit, Share, Delete

- **Notes Tab:**
  - All saved notes
  - Book title + timestamp
  - Note text
  - Buttons: Edit, Delete, Share
  - Search notes field

---

### Page 52: **Notification Center / Notification History**
**Features Included:**

- **Header:**
  - "Notifications" title
  - "Mark all as read" button

- **Notification List (Newest First):**
  - Notifications grouped by category:
    - New Releases (from authors you follow)
    - Book Club Activity
    - Recommendations
    - Social Activity (friends finished books, liked reviews)
    - System notifications
    - Promotional/Marketing

  - Each notification shows:
    - Icon/category
    - Title
    - Timestamp ("2 hours ago")
    - "Unread" indicator (blue dot if unread)
    - Tap to action (navigates to relevant page)
    - Swipe to delete

- **Empty State:**
  - "No notifications" (if none)
  - "You're all caught up!"

---

## ADDITIONAL MODALS & OVERLAYS (12 Modals Total)

### Modal 1: **Genre/Category Selection Modal**
- Appears when user needs to select genres
- Checkbox list of all genres
- Search field to filter
- "Apply" button

### Modal 2: **Share Book Modal**
- Share via: Email, SMS, Social Media, Copy Link
- Pre-filled message: "Check out [Book Name] on [App Name]"
- Custom message input optional

### Modal 3: **Rate & Review Modal**
- Star rating selector
- Title input
- Review text input
- Spoiler warning toggle
- Post button

### Modal 4: **More Options / Context Menu Modal**
- Tap ⋮ icon on any book card
- Options: Add to Shelf, Remove from Library, Mark as Finished, Share, Report Issue

### Modal 5: **Add to Shelf / Favorites Modal**
- List of existing shelves
- Checkboxes to add book to multiple shelves
- "Create New Shelf" button
- Save button

### Modal 6: **Playback Settings / EQ Presets Modal**
- Speed selector
- Volume slider
- EQ preset buttons
- Sleep timer selector
- Save defaults button

### Modal 7: **Narrator/Voice Selection Modal**
- Shows available narrators for book (if multiple)
- Human narrators list with samples
- AI narrator option (if available)
- Select button for each

### Modal 8: **Content Rating / Age Filter Modal**
- Age range selector
- Content type options
- Preview of what's included
- Apply button

### Modal 9: **Error / Network Issue Modal**
- Connection lost notification
- Retry button
- Continue offline option (if available)
- Contact support link

### Modal 10: **Feature Unlock / Paywall Modal**
- Feature name that's premium-only
- Current plan limitation
- Upgrade options (short)
- "Upgrade Now" CTA

### Modal 11: **Confirmation Modal (Generic)**
- Used for: Delete confirmation, logout confirmation, subscription cancellation
- Headline
- Description
- Cancel button
- Confirm button (usually red for destructive actions)

### Modal 12: **Search Filters / Advanced Search Modal**
- All filter options
- Multi-select checkboxes
- Sliders for price/duration
- Date range picker
- "Clear Filters" button
- "Apply Filters" button

---

## SUMMARY TABLE: Pages by Section

| Section | # of Pages | Page Numbers | Key Features |
|---------|-----------|-------------|--------------|
| Authentication & Onboarding | 4 | 1-4 | Login, signup, preferences |
| Home & Discovery | 6 | 5-9 | Home, browse, mood search, samples, countdowns |
| Player & Playback | 5 | 10-13 | Full player, mini player, car mode, bookmarks |
| Library & Management | 8 | 14-21 | Library, filters, shelves, wishlist, stats, series |
| Search & Filtering | 4 | 22-25 | Search, advanced search, results, author detail |
| Social & Community | 7 | 25-30 | Social hub, clubs, live discussion, challenges, reviews |
| Monetization & Payment | 9 | 31-39 | Plans, billing, invoices, codes, referrals |
| Accessibility & Settings | 8 | 38-45 | Accessibility, display, notifications, privacy, language |
| Kids & Family | 4 | 44-47 | Family sharing, kids mode, kids library, activity |
| User Profile & Account | 5 | 48-52 | Profile, edit, downloads, bookmarks, notifications |
| **Modals/Overlays** | **12** | Modals 1-12 | Genre select, share, rate, context menu, settings |
| **TOTAL** | **58 + 12 = 70** | — | **Complete App UI** |

---

## FEATURE-TO-PAGE MAPPING (How Features Appear in Screens)

### Playback & Audio Control
- Smart Resume → Player (Page 10)
- Silence Trimmer → Player (Page 10)
- Variable Speed → Player (Page 10) + Playback Settings Modal
- Volume Boost → Player (Page 10)
- Vocal EQ → Player (Page 10)
- Sleep Timer → Player (Page 10)
- Shake-to-Reset Timer → Player (Page 10)
- Car Mode → Page 12
- Smart Rewind → Player (Page 10)
- Cross-Device Sync → Player backend + Notifications
- Repeat Button → Player (Page 10)
- Offline Listening → Download Manager (Page 50)
- Streaming Quality → Player (Page 10) + App Settings (Page 42)
- Audio Normalization → App Settings (Page 42)
- Pitch Correction → Player (Page 10)

### Bookmarks, Notes & Highlights
- All bookmark features → Bookmarks Modal (Page 13), Saved Bookmarks (Page 51)

### Library & Organization
- Cloud Library → My Library (Page 14)
- Local File Import → Library + Settings
- Smart Tags/Shelves → My Library (Page 14) + Create Shelves Modal
- Family Sharing → Family Sharing (Page 44)
- Multi-Library Search → Search (Page 20)
- Series Grouping → Series Detail (Page 19)
- Reading Log → Stats (Page 18)
- Wishlist → Wishlist (Page 17)
- Download Manager → Page 50

### Discovery & AI
- AI Recommendations → Home (Page 5), Discover (Page 6)
- Emotional Search → Mood-Based Search (Page 7)
- Samples → Samples Feed (Page 8)
- Countdown Pages → Upcoming (Page 9)
- Similar Titles → Discovery, Recommendations
- Author/Series Follow → Author Profile (Page 23)

### Social & Community
- Sharing → Share Modal + Social Hub (Page 24)
- Book Clubs → Book Clubs (Page 25)
- Live Discussions → Page 26
- Reviews & Ratings → Review Modal + Social Hub
- Leaderboards → Reading Challenge (Page 28)

### Monetization
- All subscription/pricing features → Subscription Pages (31-37)
- Referral Program → Page 37

### Accessibility
- All accessibility features → Accessibility Settings (Page 38)

### Kids/Family
- All kids features → Kids Mode (Page 45), Kids Library (Page 46), Child Profile (Page 47)

---

## TECHNICAL NOTES FOR DEVELOPMENT

### Bottom Navigation (Fixed on all content pages)
```
[Home] [Search] [Library] [Social] [Account]
```
- Always visible (iOS) or visible as hamburger (Android)
- Tap to navigate between main sections

### Standard Header Pattern (Most pages)
- Back button (if not root screen)
- Page title centered
- Right-side actions (filter, sort, settings, share, etc.)

### Search Integration
- Search bar accessible from:
  - Home page (Page 5)
  - Bottom nav (Page 20)
  - Global search shortcut (Cmd+K or 3-tap)

### Player Minimization
- Player (Page 10) can be minimized to mini-player
- Mini-player always visible when book is playing
- Swipe up to expand full player from any screen

### Monetization Integration Points
- Subscription prompts on: Home (Page 5), Premium features unlock
- Payment setup: Pages 31-37
- Free/premium indicators throughout app

---


