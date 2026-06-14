document.addEventListener('DOMContentLoaded', () => {
    // Fade-in animation for glass containers
    const glassContainers = document.querySelectorAll('.glass-container');
    glassContainers.forEach((container, index) => {
        container.style.opacity = '0';
        container.style.transform = 'translateY(15px)';
        container.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        
        setTimeout(() => {
            container.style.opacity = '1';
            container.style.transform = 'translateY(0)';
        }, 100 * index);
    });

    // Confirmation for destructive tasks
    const deleteButtons = document.querySelectorAll('.btn-delete-confirm');
    deleteButtons.forEach(button => {
        button.addEventListener('click', (e) => {
            const confirmMsg = button.getAttribute('data-confirm') || 'Apakah Anda yakin ingin menghapus data ini?';
            if (!confirm(confirmMsg)) {
                e.preventDefault();
            }
        });
    });

    // Modal 'Lihat Semua' functionality
    const modalOverlay = document.getElementById('taskModal');
    if (modalOverlay) {
        const modalClose = modalOverlay.querySelector('.modal-close');
        const modalTitle = document.getElementById('modalTitle');
        const modalMk = document.getElementById('modalMk');
        const modalTipe = document.getElementById('modalTipe');
        const modalDeadline = document.getElementById('modalDeadline');
        const modalDesc = document.getElementById('modalDesc');

        const triggers = document.querySelectorAll('.btn-lihat-semua');
        triggers.forEach(trigger => {
            trigger.addEventListener('click', (e) => {
                console.log('Lihat Semua button clicked', trigger);
                e.preventDefault();
                const judul = trigger.getAttribute('data-judul');
                const mk = trigger.getAttribute('data-mk');
                const deadline = trigger.getAttribute('data-deadline');
                const tipe = trigger.getAttribute('data-tipe');

                // Read description safely from the hidden element inside the parent cell
                const hiddenDescEl = trigger.parentElement.querySelector('.hidden-desc');
                const deskripsi = hiddenDescEl ? hiddenDescEl.textContent : '';

                modalTitle.textContent = judul;
                modalMk.textContent = mk;
                modalDeadline.textContent = deadline;
                modalDesc.textContent = deskripsi;
                modalTipe.textContent = tipe;
                
                // Adjust the Type card background color based on type
                const typeCard = modalTipe.closest('.modal-meta-card');
                if (typeCard) {
                    if (tipe === 'Mandiri') {
                        typeCard.style.backgroundColor = 'var(--warning)';
                    } else {
                        typeCard.style.backgroundColor = 'var(--primary)';
                    }
                }

                modalOverlay.classList.add('active');
            });
        });

        // Close modal triggers
        modalClose.addEventListener('click', () => {
            modalOverlay.classList.remove('active');
        });

        modalOverlay.addEventListener('click', (e) => {
            if (e.target === modalOverlay) {
                modalOverlay.classList.remove('active');
            }
        });

        // Close on Escape key
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape' && modalOverlay.classList.contains('active')) {
                modalOverlay.classList.remove('active');
            }
        });
    }
});
