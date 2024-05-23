// script.js

document.addEventListener("DOMContentLoaded", function() {
    // 좋아요 버튼 요소를 가져옵니다.
    var likeBtn = document.querySelector(".like-btn");
    // 좋아요 숫자를 표시하는 요소를 가져옵니다.
    var likeCount = document.getElementById("like-count");
    // 좋아요 상태를 저장하기 위한 변수를 초기화합니다.
    var isLiked = false;
    // 한 번만 누를 수 있도록 하는 상태 변수를 초기화합니다.
    var isAlreadyLiked = false;

    // 사용자가 좋아요 버튼을 클릭했을 때 실행될 함수를 설정합니다.
    likeBtn.addEventListener("click", function() {
        // 이미 좋아요를 누른 상태라면
        if (isLiked) {
            // 좋아요를 취소합니다.
            // 좋아요 상태를 취소하고, 하트 아이콘을 비어있는 상태로 변경합니다.
            likeBtn.innerHTML = "좋아요♡";
            // 좋아요 숫자를 감소시킵니다.
            likeCount.textContent = parseInt(likeCount.textContent) - 1;
            // 좋아요 상태를 false로 변경합니다.
            isLiked = false;
            // 좋아요 취소 후 다시 좋아요를 누를 수 있도록 상태를 변경합니다.
            isAlreadyLiked = false;
        } else {
            // 좋아요를 누르지 않은 상태라면
            // 좋아요를 누릅니다.
            // 좋아요 상태를 설정하고, 하트 아이콘을 채워진 상태로 변경합니다.
            likeBtn.innerHTML = "좋아요❤️";
            // 좋아요 숫자를 증가시킵니다.
            likeCount.textContent = parseInt(likeCount.textContent) + 1;
            // 좋아요 상태를 true로 변경합니다.
            isLiked = true;
            // 한 번만 누를 수 있도록 상태를 변경합니다.
            isAlreadyLiked = true;
        }
    });
});