# *****************************************
# 関数型メソッド

# エンターキーが押されると、スロットの結果を1列ずつ表示するメソッド
def play_slot_game
  index_of_top_of_reel = 0
  slot_reels           = []

  3.times do
    gets   # エンターが入力されれば、以下の処理が実行される。

    # スロット1列ずつに1~9の値を設定する。
    temp_array                                                 =  (1..9).to_a
    slot_reels[index_of_top_of_reel..index_of_top_of_reel + 2] =  temp_array.sample(3)
    index_of_top_of_reel                                       += 3

    # スロットの結果を出力する。
    puts "|#{slot_reels[0]}|#{slot_reels[3]}|#{slot_reels[6]}|"
    puts "|#{slot_reels[1]}|#{slot_reels[4]}|#{slot_reels[7]}|"
    puts "|#{slot_reels[2]}|#{slot_reels[5]}|#{slot_reels[8]}|"
    puts "\n-----------"
  end

  return slot_reels
end


# スロットの画面において、横 もしくは 斜め に数字が揃っているような列の数を集計して返す。
def count_aligned_row_number_of_reels (reels)
  total_aligned_number = 0
  row_number_minus_1   = 0

  # 1行ずつ数字が横1行に揃っているかチェックし、揃っている行数を集計。
  3.times do
    if reels[row_number_minus_1] == reels[row_number_minus_1 + 3] && reels[row_number_minus_1 + 3] == reels[row_number_minus_1 + 6]
      total_aligned_number += 1
    end
    row_number_minus_1 += 1
  end

  # 数字が斜めに揃っているような列の数を集計。
  if reels[0] == reels[4] && reels[4] == reels[8]
    total_aligned_number += 1
  end
  if reels[2] == reels[4] && reels[4] == reels[6]
    total_aligned_number += 1
  end

    return total_aligned_number
end


# *****************************************
# メイン処理
# オブジェクトの定義
residual_coin = 100   # 初期コイン数は100コインとする
current_point = 0
continue_game = true

# スロットゲーム処理
while continue_game == true
  puts '-----------'
  puts "残りコイン数：#{residual_coin}"
  puts "ポイント　　：#{current_point}"
  puts '何コイン入れますか？'
  puts '1(10コイン), 2(20コイン), 3(50コイン), 4(やめておく)'
  puts '-----------'
  selected_option = gets.to_s.chomp

  case selected_option
  when '1', '2', '3'
    selected_option = selected_option.to_i
    coin_numbers    = [10, 20, 50]
    consumed_coin   = coin_numbers[selected_option - 1]

    # コインが足りなかった場合の処理。
    if residual_coin < consumed_coin
      puts 'コインが足りません。コインの数を選択し直してください。'

    # コインが足りている場合の処理。
    else
      residual_coin -= consumed_coin
      puts 'スロットスタート！'
      puts 'エンターを3回押しましょう！'
      puts '-----------'

      # スロットゲームを実施するメソッドの実行
      slot_reels = play_slot_game

      # スロットゲーム実施後、数字が揃った列を集計するメソッドの実行し、揃った列数を受け取る。
      total_aligned_number = count_aligned_row_number_of_reels(slot_reels)

      # 揃った列が１列でもあった場合
      unless total_aligned_number == 0
        earned_point  =  total_aligned_number * 500
        earned_coin   =  total_aligned_number * 100
        current_point += earned_point
        residual_coin += earned_coin
        puts "#{total_aligned_number}列揃いました！"
        puts "#{earned_point}ポイント獲得！"
        puts "#{earned_coin}コイン獲得！"
        puts '-----------'

      # 一列も揃わなかった場合
      else
        puts '残念... 一列も揃いませんでした...'
        puts '-----------'
      end

      # 残りのコインが0の場合は処理を終了する。
      if residual_coin == 0
        continue_game = false
        puts 'コインがなくなりました。'
        puts 'また遊んでね。'
        puts '-----END-----'
      end
    end

  when '4'
    continue_game = false
    puts 'また遊んでね。'
    puts '-----END-----'

  else
    puts '1,2,3,4のいずれかを入力してください。'
  end
end
