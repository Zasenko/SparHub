//
//  Post.swift
//  SparHub
//
//  Created by Dmitry Zasenko on 01.04.26.
//

import SwiftUI

enum PostCategory: String, Codable, CaseIterable {
    case post, mems, news, question, all
}

struct Post: Codable, Identifiable {
    let id: Int
    let title: String
    let text: String
    let imgUrl: String?
    let category: PostCategory
    let dateString: String
    let user: User
    
    var isLiked: Bool = false
    var isMarked: Bool = false
    var date: Date = Date()
    
    enum CodingKeys: String, CodingKey {
            case id, title, text, imgUrl, category, dateString = "date", user
    }
}

let postsDTO: [Post] = [
    Post(id: 1,
         title: "Hello world!",
         text: "Мы используем cookie-файлы, чтобы помочь этому сайту функционировать, понимать использование услуг и поддерживать маркетинговые усилия. Посетите «Управление cookie-файлами», чтобы изменить настройки в любое время. Ознакомьтесь с нашей политикой использования cookie-файлов для получения дополнительной информации.",
         imgUrl: "https://img.freepik.com/free-photo/a-small-dog-of-the-welsh-corgi-breed-sits-at-the-feet-of-his-mistress-woman-on-a-walk-with-a-dog_199743-7303.jpg", category: .news,
         dateString: "2026-03-26T14:23:00Z", user: usersDTO[0]),
    Post(id: 2,
         title: "Second Post",
         text: "Zasenko, navigay.me is active and its nameservers are set to ns1.dns-parking.com / ns2.dns-parking.com, so the domain side looks OK (no verification/hold issue). If it’s still “connecting” after ~2 days, it usually means the DNS zone is still pointing to old/wrong records somewhere (or your device/ISP is caching them). Open your DNS zone and check these: A record for @ must point to your Hostinger website IP (and not to an old IP like 185.53.179.136) www should be a CNAME to @ (or an A record to the same Hostinger IP) Go here in hPanel to check/edit: Domains → DNS Zone.",
         imgUrl: nil, category: .mems,
         dateString: "2026-03-25T14:23:00Z", user: usersDTO[1]),
    Post(id: 3,
         title: "Let's help you find what you need!",
         text: "There is growing evidence that taking into account the needs of different types of employees is not just a nice-to-have. About 50 percent of the workforce is introverted, but 96 percent of leaders identify as extroverts. Companies that nurture cognitive diversity within their teams tend to have more engaged cultures.",
         imgUrl: nil, category: .news,
         dateString: "2026-01-25T14:10:00Z", user: usersDTO[0]),
    Post(id: 4,
         title: "What is an aptitude test?",
         text: "An aptitude test is a way to measure a job candidate’s cognitive abilities, work behaviours, or personality traits. Aptitude tests will examine your numeracy, logic and problem-solving skills, as well as how you deal with work situations. They are a proven method to assess employability skills. Aptitude tests measure a range of skills such as numerical ability, language comprehension and logical reasoning. What are the different types of aptitude tests? There are a number of different types of aptitude test due to the range of cognitive capabilities and employer priorities. At Practice Aptitude Tests, we provide industry standard aptitude or psychometric tests for banking, accountancy, finance, law, engineering, business, marketing and vocational fields. The most commonly used are numerical reasoning tests, verbal reasoning tests, diagrammatic reasoning tests, situational judgement tests , mechanical reasoning tests and personality tests.",
         imgUrl: "https://www.practiceaptitudetests.com/assets/images/home-hero.png", category: .news,
         dateString: "2026-02-25T14:10:00Z", user: usersDTO[2]),
    Post(id: 5,
         title: "The Medium Algorithm Explained",
         text: "In the vast realm of online content, algorithms play a pivotal role in shaping the user experience. For platforms like Medium, the algorithm is the invisible force that determines what articles, stories, and ideas surface to your attention. In this article, we will delve into the intricacies of the Medium algorithm, demystifying its workings and shedding light on how it influences content discovery. Understanding Medium’s Mission: Medium, founded by Evan Williams and Biz Stone, aims to provide a platform where people can share their stories and ideas without the noise of advertisements and clickbait. The algorithm is designed to help users discover high-quality, relevant content based on their interests, reading habits, and engagement history. Key Factors Influencing the Medium Algorithm: User Preferences: Medium’s algorithm takes into account your reading history and engagement patterns. It analyzes the topics, authors, and types of content you interact with to tailor recommendations specifically to your interests. Relevance: The algorithm considers the freshness of content. Recently published stories that align with your preferences are more likely to be recommended. Additionally, the relevance of the content to your past readings is a crucial factor.",
         imgUrl: "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*Q7WGhJE-2pH9eqN8rVv59w@2x.jpeg", category: .post,
         dateString: "2026-02-27T07:00:00Z", user: usersDTO[3]),
    Post(id: 6,
         title: "Fnance or marketing",
         text: "Aptitude tests are assessments designed to measure an individual’s natural ability or potential to perform specific tasks, such as logical reasoning, numerical ability, or spatial awareness, without prior training. Commonly used in hiring and education, they help predict performance in roles like engineering, finance, or marketing.",
         imgUrl: nil, category: .news,
         dateString: "2026-03-26T14:15:00Z", user: usersDTO[2])
]
