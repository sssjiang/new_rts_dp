document.querySelectorAll('pre > code').forEach(function (codeBlock) {
    // Create copy button element
    var copyButton = document.createElement('button');
    copyButton.className = 'copy-code-button';
    copyButton.type = 'button';
    copyButton.innerText = 'Copy';

    // Set button position to top right corner
    copyButton.style.position = 'absolute';
    copyButton.style.top = '0';
    copyButton.style.right = '0';

    // Append copy button to code block
    codeBlock.parentNode.style.position = 'relative';
    codeBlock.parentNode.appendChild(copyButton);

    // Add click event listener to copy button
    copyButton.addEventListener('click', function () {
        // Create range object
        var range = document.createRange();
        range.selectNode(codeBlock);

        // Add range to selection
        window.getSelection().addRange(range);

        // Copy text to clipboard
        document.execCommand('copy');

        // Remove range from selection
        window.getSelection().removeAllRanges();

        // Show confirmation tooltip
        copyButton.classList.add('copied');
        setTimeout(function () {
            copyButton.classList.remove('copied');
        }, 2000);
    });
});