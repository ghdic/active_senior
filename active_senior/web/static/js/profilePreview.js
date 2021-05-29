
profile.onchange = (e) => {
    const [file] = profile.files;
    if (file) {
        profilePreview.src = URL.createObjectURL(file)
    }
}