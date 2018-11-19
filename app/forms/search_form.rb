class SearchForm
  include ActiveModel::Model

  SEARCH_KEY = [
    ['札幌', 'sapporo'], ['青森', 'aomori'], ['盛岡', 'morioka'], ['仙台', 'sendai'], ['秋田', 'akita'],['山形', 'yamagata'],
    ['福島', 'fukushima'], ['水戸', 'mito'], ['宇都宮', 'utsunomiya'], ['前橋', 'maebashi'],['さいたま', 'saitama'], ['千葉', 'chiba'],
    ['東京', 'tokyo'], ['横浜', 'yokohama'], ['新潟', 'niigata'], ['富山', 'toyama'], ['金沢', 'kanazawa'], ['福井', 'fukui'],
    ['甲府', 'kofu'], ['長野', 'nagano'], ['岐阜', 'gifu'], ['静岡', 'shizuoka'], ['名古屋', 'nagoya'], ['津', 'tsu'],
    ['大津', 'otsu'], ['京都', 'kyoto'], ['大阪', 'osaka'], ['神戸', 'kobe'], ['奈良', 'nara'], ['和歌山', 'wakayama'],
    ['鳥取', 'tottori'], ['松江', 'matsue'], ['岡山', 'okayama'], ['広島', 'hiroshima'], ['山口', 'yamaguchi'], ['徳島', 'tokushima'],
    ['高松', 'takamatsu'], ['松山', 'matsuyama'], ['高知', 'kochi'], ['福岡', 'fukuoka'], ['佐賀', 'saga'], ['長崎', 'nagasaki'],
    ['熊本', 'kumamoto'], ['大分', 'oita'], ['宮崎', 'miyazaki'], ['鹿児島', 'kagoshima'], ['那覇', 'okinawa']
  ].freeze
end
